import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/saved_recipe_model.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class SavedRecipeService with ListenableServiceMixin {
  List<SavedRecipeModel> savedRecipes = [];
  bool isInitialised = false;
  Future<void> init() async {
    savedRecipes = await _getSavedRecipesForUser(firebaseAuth.currentUser!.uid);
    notifyListeners();
    isInitialised = true;
  }

  Future<bool> _addSavedRecipe(SavedRecipeModel savedRecipe) async {
    DocumentReference newRecipeRef =
        await firebasestore.collection('savedRecipes').add(savedRecipe.toMap());
    await newRecipeRef.update({'docId': newRecipeRef.id});
    savedRecipe.docId = newRecipeRef.id;
    savedRecipes.add(savedRecipe);
    showToast(message: 'Recipe saved successfully');
    notifyListeners();
    return true;
  }

  Future<bool> _removeSavedRecipe(SavedRecipeModel savedRecipe) async {
    // savedRecipes.removeWhere((element) => element.docId == savedRecipe.docId);
    savedRecipes
        .removeWhere((recipe) => recipe.recipeId == savedRecipe.recipeId);
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('savedRecipes')
        .where('recipeId', isEqualTo: savedRecipe.recipeId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final DocumentSnapshot docSnapshot = querySnapshot.docs.first;
      await docSnapshot.reference.delete();
      showToast(message: 'Recipe deleted successfully');
    }
    notifyListeners();
    return true;
  }

  Future<bool> addSavedRecipe(SavedRecipeModel savedRecipe) async {
    log('savedRecipe: ${savedRecipe.docId}');
    log('saved: ${savedRecipes.map((e) => e.docId)}');
    try {
      EasyLoading.show(); // Show loading indicator
      if (!isInitialised) {
        throw "Service not initialised";
      }

      if (savedRecipes.map((e) => e.recipeId).contains(savedRecipe.recipeId)) {
        _removeSavedRecipe(savedRecipe);
      } else {
        _addSavedRecipe(savedRecipe);
      }
      notifyListeners();

      EasyLoading.dismiss(); // Dismiss loading indicator
      // Show success message
      return true;
    } catch (error) {
      EasyLoading.dismiss(); // Dismiss loading indicator
      showToast(message: 'Error saving recipe: $error'); // Show error message
      return false;
    }
  }

  Future<List<SavedRecipeModel>> _getSavedRecipesForUser(String userId) async {
    List<SavedRecipeModel> savedRecipes = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('savedRecipes')
          .where('userId', isEqualTo: userId)
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        SavedRecipeModel savedRecipe = SavedRecipeModel.fromSnapshot(doc);
        // Fetch recipe details using recipeId
        RecipeModel? recipeModel =
            await fetchRecipeDetails(savedRecipe.recipeId);
        // Update the recipeModel property
        savedRecipe.recipeModel = recipeModel;
        savedRecipes.add(savedRecipe);
      }

      return savedRecipes;
    } catch (error) {
      return [];
    }
  }

  Future<RecipeModel?> fetchRecipeDetails(String recipeId) async {
    try {
      DocumentSnapshot recipeSnapshot = await FirebaseFirestore.instance
          .collection('recipes')
          .doc(recipeId)
          .get();

      if (recipeSnapshot.exists) {
        return RecipeModel.fromSnapshot(recipeSnapshot);
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
