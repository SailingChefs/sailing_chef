import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/saved_recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class SavedRecipeService with ListenableServiceMixin {
  List<RecipeModel> savedRecipes = [];
  final RecipeService _recipeService = locator<RecipeService>();

  bool isInitialised = false;
  // final _userService = locator<UserServices>();

  Future<void> init() async {
    savedRecipes.clear();
    await mySavedRecipes();
    // if(isInitialised) return;
    // savedRecipes = await _fetchSavedRecipes();
    isInitialised = true;
    notifyListeners();
  }

  Future<void> mySavedRecipes() async {
    if (RecipeService.recipes.isEmpty) {
      await _recipeService.fetchRecipesByUID(userDetails!.uid!);
      return;
    }

    for (final recipe in RecipeService.recipes) {
      if (userDetails!.savedRecipes!.any((element) => element == recipe.docId)) {
        savedRecipes.add(recipe);
      }
    }
  }

  Future<void> _addSavedRecipe(RecipeModel savedRecipe) async {
    try {
      await firebasestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid) // Assuming currentUser contains the user's data
          .update({
        'saved_Recipes': FieldValue.arrayUnion([savedRecipe.docId])
      });
      savedRecipes.add(savedRecipe);
      userDetails!.savedRecipes!.add(savedRecipe.docId!);
      savedRecipesGlobal.add(savedRecipe);
      log(userDetails!.savedRecipes?.toString() ?? 'No saved recipes found');
      // showToast(message: 'Recipe saved successfully');
      notifyListeners();
    } catch (e) {
      showToast(message: 'Error saving recipe: $e');
    }
  }

  Future<void> _removeSavedRecipe(String recipeId) async {
    try {
      await firebasestore.collection('users').doc(firebaseAuth.currentUser!.uid).update({
        'saved_Recipes': FieldValue.arrayRemove([recipeId])
      });

      // showToast(message: 'Recipe removed successfully');
      notifyListeners();
      savedRecipes.removeWhere((recipe) => recipe.docId == recipeId);
      userDetails!.savedRecipes!.removeWhere((recipe) => recipe == recipeId);
      savedRecipesGlobal.removeWhere((recipe) => recipe.docId == recipeId);
      notifyListeners();
    } catch (e) {
      // Handle error as needed
    }
  }

  bool addSavedRecipe(RecipeModel savedRecipe) {
    try {
      // if (!isInitialised) {
      //   throw "Service not initialised";
      // }

      if (userDetails!.savedRecipes!.map((e) => e).contains(savedRecipe.docId)) {
        _removeSavedRecipe(savedRecipe.docId!);
      } else {
        _addSavedRecipe(savedRecipe);
      }

      notifyListeners();

      return true;
    } catch (error) {
      showToast(message: 'Error saving recipe: $error');
      return false;
    }
  }

  Future<List<SavedRecipeModel>> fetchUserSavedRecipes(String userId) async {
    try {
      final DocumentSnapshot userDoc = await firebasestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        final savedRecipeIds = userDoc.data() as Map<String, dynamic>?;

        // Initialize an empty list to store saved recipes
        final savedRecipes = <SavedRecipeModel>[];

        // If the user has saved recipes, fetch each recipe and add it to the list
        if (savedRecipeIds != null && savedRecipeIds.containsKey('saved_Recipes')) {
          final savedRecipeIdsList = savedRecipeIds['saved_Recipes'] as List<dynamic>;
          for (final recipeId in savedRecipeIdsList) {
            final DocumentSnapshot recipeDoc =
                await firebasestore.collection('recipes').doc(recipeId as String).get();
            if (recipeDoc.exists) {
              final recipeModel = RecipeModel.fromSnapshot(recipeDoc);
              final recipeUserId = recipeModel.uid;
              final DocumentSnapshot userSnapshot =
                  await firebasestore.collection('users').doc(recipeUserId).get();
              if (userSnapshot.exists) {
                final userModel = UserModel.fromSnapshot(userSnapshot);
                recipeModel.user = userModel;
                savedRecipes
                    .add(SavedRecipeModel(recipeId: recipeModel.docId!, recipeModel: recipeModel));
              }
            }
          }
        }

        return savedRecipes;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // Future<List<SavedRecipeModel>> _getSavedRecipeIdsForUser(
  //     String userId) async {
  //   List<SavedRecipeModel> savedRecipes = [];
  //   List<String> savedRecipeIds = [];
  //   try {
  //     DocumentSnapshot userDoc =
  //         await firebasestore.collection('users').doc(userId).get();

  //     if (userDoc.exists) {
  //       Map<String, dynamic>? userData = userDoc.data()
  //           as Map<String, dynamic>?; // Cast to Map<String, dynamic>?
  //       if (userData != null && userData.containsKey('saved_Recipes')) {
  //         savedRecipeIds = List<String>.from(userData['saved_Recipes']
  //             as List<dynamic>); // Cast to List<dynamic>
  //       }

  //       for (String savedRecipeId in savedRecipeIds) {
  //         RecipeModel? recipeModel = await _fetchRecipeDetails(savedRecipeId);
  //         UserModel? currUser = await _userService
  //             .fetchUserByUID(FirebaseAuth.instance.currentUser!.uid);
  //         if (!currUser.blockedAccounts!.contains(recipeModel!.uid)) {
  //           UserModel? user =
  //               await _userService.fetchUserByUID(recipeModel.uid);
  //           recipeModel.user = user;
  //           savedRecipeIds.add(savedRecipeId);
  //         }
  //         savedRecipes.add(SavedRecipeModel(
  //           recipeId: savedRecipeId,
  //           recipeModel: recipeModel,
  //         ));
  //       }
  //     } else {}
  //   } catch (e) {
  //     // Handle error as needed
  //   }
  //   return savedRecipes;
  // }

  // Future<RecipeModel?> _fetchRecipeDetails(String recipeId) async {
  //   try {
  //     DocumentSnapshot recipeSnapshot = await FirebaseFirestore.instance
  //         .collection('recipes')
  //         .doc(recipeId)
  //         .get();

  //     if (recipeSnapshot.exists) {
  //       return RecipeModel.fromSnapshot(recipeSnapshot);
  //     } else {
  //       return null;
  //     }
  //   } catch (error) {
  //     return null;
  //   }
  // }
}
