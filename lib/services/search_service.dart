import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/user_services.dart';

import '../app/app.locator.dart';

class SearchService {
  final CollectionReference recipesCollection =
      FirebaseFirestore.instance.collection('recipes');
  final _userService = locator<UserServices>();

  final CollectionReference pinsCollection = firebasestore.collection('pins');

  Future<List<RecipeModel>> filterRecipes(String query) async {
    try {
      final QuerySnapshot querySnapshot = await recipesCollection
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThan: '$query\uf8ff')
          .get();

      final List<RecipeModel> filteredRecipes = [];
      for (var doc in querySnapshot.docs) {
        RecipeModel recipe = RecipeModel.fromSnapshot(doc);
        UserModel? currUser =
            await _userService.fetchUserByUID(firebaseAuth.currentUser!.uid);
        if (!currUser.blockedAccounts!.contains(recipe.uid)) {
          UserModel? user = await _userService.fetchUserByUID(recipe.uid);
          recipe.user = user;
          filteredRecipes.add(recipe);
        }
      }

      return filteredRecipes;
    } catch (error) {
      return [];
    }
  }

  Future<List<PinnedLocation>> filterPinnedLocations(String query) async {
    try {
      if (query.trim().isEmpty) return [];

      final String lowercaseQuery = query.toLowerCase().trim();

      // Combine all results and remove duplicates
      Set<String> seenIds = {};
      List<PinnedLocation> allResults = [];

      // Search by name (existing functionality)
      final QuerySnapshot nameQuerySnapshot = await pinsCollection
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: '$query\uf8ff')
          .get();

      // Also search by lowercase name for case-insensitive search
      final QuerySnapshot lowercaseNameQuery = await pinsCollection
          .where('name', isGreaterThanOrEqualTo: lowercaseQuery)
          .where('name', isLessThan: '$lowercaseQuery\uf8ff')
          .get();

      // Search by tags (new functionality)
      final QuerySnapshot tagsQuerySnapshot =
          await pinsCollection.where('tags', arrayContainsAny: [
        query,
        lowercaseQuery,
        _capitalizeFirstLetter(lowercaseQuery),
      ]).get();

      // Search by description (new functionality)
      final QuerySnapshot descriptionQuerySnapshot = await pinsCollection
          .where('description', isGreaterThanOrEqualTo: lowercaseQuery)
          .where('description', isLessThan: '$lowercaseQuery\uf8ff')
          .get();

      // Search by place (new functionality)
      final QuerySnapshot placeQuerySnapshot = await pinsCollection
          .where('place', isGreaterThanOrEqualTo: lowercaseQuery)
          .where('place', isLessThan: '$lowercaseQuery\uf8ff')
          .get();

      // Process all query results
      for (var querySnapshot in [
        nameQuerySnapshot,
        lowercaseNameQuery,
        tagsQuerySnapshot,
        descriptionQuerySnapshot,
        placeQuerySnapshot,
      ]) {
        for (var doc in querySnapshot.docs) {
          if (!seenIds.contains(doc.id)) {
            seenIds.add(doc.id);
            PinnedLocation pin = PinnedLocation.fromSnapshot(doc);
            // Additional client-side filtering for better matches
            if (_isRelevantMatch(pin, lowercaseQuery)) {
              allResults.add(pin);
            }
          }
        }
      }

      // Sort results by relevance
      allResults.sort((a, b) => _calculateRelevanceScore(b, lowercaseQuery)
          .compareTo(_calculateRelevanceScore(a, lowercaseQuery)));

      return allResults;
    } catch (error) {
      // Return empty list on error instead of printing
      return [];
    }
  }

  bool _isRelevantMatch(PinnedLocation pin, String query) {
    final String lowerQuery = query.toLowerCase();

    // Check name (most important)
    if (pin.name.toLowerCase().contains(lowerQuery)) return true;

    // Check tags
    for (String tag in pin.tags) {
      if (tag.toLowerCase().contains(lowerQuery)) return true;
    }

    // Check description
    if (pin.description.toLowerCase().contains(lowerQuery)) return true;

    // Check place
    if (pin.place.toLowerCase().contains(lowerQuery)) return true;

    return false;
  }

  int _calculateRelevanceScore(PinnedLocation pin, String query) {
    int score = 0;
    final String lowerQuery = query.toLowerCase();

    // Exact name match gets highest score
    if (pin.name.toLowerCase() == lowerQuery) score += 100;

    // Name starts with query gets high score
    if (pin.name.toLowerCase().startsWith(lowerQuery)) score += 50;

    // Name contains query gets medium score
    if (pin.name.toLowerCase().contains(lowerQuery)) score += 25;

    // Tag exact match
    for (String tag in pin.tags) {
      if (tag.toLowerCase() == lowerQuery) score += 75;
      if (tag.toLowerCase().contains(lowerQuery)) score += 15;
    }

    // Description contains query
    if (pin.description.toLowerCase().contains(lowerQuery)) score += 10;

    // Place contains query
    if (pin.place.toLowerCase().contains(lowerQuery)) score += 5;

    return score;
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
