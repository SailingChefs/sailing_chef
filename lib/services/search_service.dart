import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/model/recipe_model.dart';

class SearchService {
  final CollectionReference recipesCollection =
      FirebaseFirestore.instance.collection('recipes');

  Future<List<RecipeModel>> filterRecipes(String query) async {
    try {
      // Fetch recipes from Firestore where the title contains the query
      final QuerySnapshot querySnapshot = await recipesCollection
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThan: '$query\uf8ff')
          .get();

      // Convert the retrieved documents into RecipeModel objects
      final List<RecipeModel> filteredRecipes = querySnapshot.docs
          .map((doc) => RecipeModel.fromSnapshot(doc))
          .toList();

      return filteredRecipes;
    } catch (error) {
      // Handle errors if any
      return []; // Return an empty list if an error occurs
    }
  }
}
