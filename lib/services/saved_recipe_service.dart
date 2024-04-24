import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/saved_recipe_model.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class SavedRecipeService with ListenableServiceMixin{
  List<SavedRecipeModel> savedRecipes = [];

  addSavedRecipeLocally(SavedRecipeModel savedRecipe) async {
    bool check = await addSavedRecipe(savedRecipe);
    if (check) {
      savedRecipes.add(savedRecipe);
    }
    notifyListeners();
  }

  deleteSavedRecipeLocally(SavedRecipeModel savedRecipe) async {
    bool check = await deleteSavedRecipe(savedRecipe.docId);
    if (check) {
      savedRecipes.remove(savedRecipe);
    }
     notifyListeners();
  }

  getAllSavedRecipes() async {
    savedRecipes = await getSavedRecipesForUser(firebaseAuth.currentUser!.uid);
  }

  clearSavedRecipes() {
    savedRecipes.clear();
  }

 Future<bool> addSavedRecipe(SavedRecipeModel savedRecipe) async {
  try {
    EasyLoading.show(); // Show loading indicator
    // Query Firestore to check if a recipe with the same ID exists
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('savedRecipes')
        .where('recipeId', isEqualTo: savedRecipe.recipeId)
        .get();

    // If a recipe with the same ID exists, delete it before adding the new one
    if (querySnapshot.docs.isNotEmpty) {
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    }

    // Add the new saved recipe
    DocumentReference docRef = await FirebaseFirestore.instance
        .collection('savedRecipes')
        .add(savedRecipe.toMap());

    // Update the document with the newly generated document ID
    await docRef.update({'docId': docRef.id});

    EasyLoading.dismiss(); // Dismiss loading indicator
    showToast(message: 'Recipe saved successfully'); // Show success message
    return true;
  } catch (error) {
    EasyLoading.dismiss(); // Dismiss loading indicator
    showToast(message: 'Error saving recipe: $error'); // Show error message
    return false;
  }
}
  // Function to delete a saved recipe from Firestore
  Future<bool> deleteSavedRecipe(String recipeId) async {
    try {
      await firebasestore.collection('savedRecipes').doc(recipeId).delete();
      return true;
    } catch (error) {
      return false;
    }
  }

  // Function to fetch all saved recipes for a specific user from Firestore
  Future<List<SavedRecipeModel>> getSavedRecipesForUser(String userId) async {
    List<SavedRecipeModel> savedRecipes = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('savedRecipes')
          .where('userId', isEqualTo: userId)
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        savedRecipes.add(SavedRecipeModel.fromSnapshot(doc));
      }

      return savedRecipes;
    } catch (error) {
      return [];
    }
  }
}
