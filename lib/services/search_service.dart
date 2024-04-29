import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/model/recipe_model.dart';

class SearchService {
  final CollectionReference recipesCollection =
      FirebaseFirestore.instance.collection('recipes');
  final CollectionReference pinsCollection =
      FirebaseFirestore.instance.collection('pins');
  Future<List<RecipeModel>> filterRecipes(String query) async {
    try {
      final QuerySnapshot querySnapshot = await recipesCollection
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThan: '$query\uf8ff')
          .get();

      final List<RecipeModel> filteredRecipes = querySnapshot.docs
          .map((doc) => RecipeModel.fromSnapshot(doc))
          .toList();

      return filteredRecipes;
    } catch (error) {
      return []; 
    }
  }

  Future<List<PinnedLocation>> filterPinnedLocations(String query) async {
    try {
      final QuerySnapshot querySnapshot = await pinsCollection
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: '$query\uf8ff')
          .get();

      final List<PinnedLocation> filteredPins = querySnapshot.docs
          .map((doc) => PinnedLocation.fromSnapshot(doc))
          .toList();

      return filteredPins;
    } catch (error) {
      return [];
    }
  }
}
