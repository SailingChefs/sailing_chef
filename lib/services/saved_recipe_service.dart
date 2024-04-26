import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/saved_recipe_model.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class SavedRecipeService with ListenableServiceMixin {
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
      EasyLoading.show(); 
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('savedRecipes')
          .where('recipeId', isEqualTo: savedRecipe.recipeId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          await doc.reference.delete();
        }
      }
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('savedRecipes')
          .add(savedRecipe.toMap());

      await docRef.update({'docId': docRef.id});

      EasyLoading.dismiss(); 
      showToast(message: 'Recipe saved successfully'); 
      return true;
    } catch (error) {
      EasyLoading.dismiss();
      showToast(message: 'Error saving recipe: $error'); 
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
