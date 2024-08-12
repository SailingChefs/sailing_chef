import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/saved_recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

import '../model/user_model.dart';

class SavedRecipeService with ListenableServiceMixin {
  List<RecipeModel>savedRecipes = [];
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
Future< void> mySavedRecipes()async{
    if (RecipeService.recipes.isEmpty) {
        await _recipeService.fetchRecipesByUID(userDetails!.uid!);
      return;
    }
   
    for(final recipe in RecipeService.recipes)
    {if(userDetails!.savedRecipes!.any((element) => element == recipe.docId)){
      savedRecipes.add(recipe);
    }}
   
  }

  Future<void> _addSavedRecipe(RecipeModel savedRecipe) async {
    try {
      await firebasestore
          .collection('users')
          .doc(firebaseAuth.currentUser!
              .uid) // Assuming currentUser contains the user's data
          .update({
        'saved_Recipes': FieldValue.arrayUnion([savedRecipe.docId])
      });
      savedRecipes.add(savedRecipe);
      userDetails!.savedRecipes!.add(savedRecipe.docId!);
      log(userDetails!.savedRecipes.toString());
      showToast(message: 'Recipe saved successfully');
      notifyListeners();
    } catch (e) {
      showToast(message: 'Error saving recipe: $e');
    }
  }

  Future<void> _removeSavedRecipe(String recipeId) async {
    try {
      await firebasestore
          .collection('users')
          .doc(firebaseAuth.currentUser!
              .uid) // Assuming currentUser contains the user's data
          .update({
        'saved_Recipes': FieldValue.arrayRemove([recipeId])
      });
      showToast(message: 'Recipe removed successfully');
      savedRecipes.removeWhere((recipe) => recipe.docId == recipeId);
      userDetails!.savedRecipes!.removeWhere((recipe) => recipe == recipeId);
      notifyListeners();
    } catch (e) {
      // Handle error as needed
    }
  }

  Future<bool> addSavedRecipe(RecipeModel savedRecipe) async {
    try {
      // if (!isInitialised) {
      //   throw "Service not initialised";
      // }

      if (userDetails!.savedRecipes!.map((e) => e).contains(savedRecipe.docId!)) {
        _removeSavedRecipe(savedRecipe.docId!);
      } else {
        _addSavedRecipe(savedRecipe);
      }
      notifyListeners();

      return true;
    } catch (error) {
      showToast(message: 'Error saving recipe: $error'); // Show error message
      return false;
    }
  }

  // Future<List<SavedRecipeModel>> _fetchSavedRecipes() async {
  //   try {
  //     String userId = firebaseAuth.currentUser!.uid;
  //     DocumentSnapshot userDoc =
  //         await firebasestore.collection('users').doc(userId).get();

  //     if (userDoc.exists) {
  //       Map<String, dynamic> savedRecipeIds =
  //           userDoc.data()! as Map<String, dynamic>;
  //       List<SavedRecipeModel> savedRecipes = [];
  //       if (savedRecipeIds.containsKey('saved_Recipes')) {
  //         List<dynamic> savedRecipeIdsList =
  //             savedRecipeIds['saved_Recipes'] as List<dynamic>;
  //         for (var recipeId in savedRecipeIdsList) {
  //           DocumentReference recipeRef =
  //               firebasestore.collection('recipes').doc(recipeId);
  //           DocumentSnapshot recipeDoc = await recipeRef.get();
  //           if (recipeDoc.exists) {
  //             RecipeModel recipeModel = RecipeModel.fromSnapshot(recipeDoc);
  //             String recipeUserId = recipeModel.uid;
  //             QuerySnapshot commentsSnapshot =
  //                 await recipeDoc.reference.collection('comments').get();

  //                 if(commentsSnapshot.docs.isEmpty){
  //                   recipeModel.comment = [];
  //                 }
  //             List<CommentModel> comments = commentsSnapshot.docs
  //                 .map((commentDoc) => CommentModel.fromSnapshot(commentDoc))
  //                 .toList();
  //             recipeModel.comment = comments;
             
  //             DocumentSnapshot userSnapshot = await firebasestore
  //                 .collection('users')
  //                 .doc(recipeUserId)
  //                 .get();
              
  //             if (userSnapshot.exists) {
  //               UserModel userModel = UserModel.fromSnapshot(userSnapshot);
  //               recipeModel.user = userModel;
  //               savedRecipes.add(SavedRecipeModel(
  //                   recipeId: recipeModel.docId!, recipeModel: recipeModel));
  //             }
  //           }
  //         }
  //       }
  //       return savedRecipes;
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     return [];
  //   }
  // }

  Future<List<SavedRecipeModel>> fetchUserSavedRecipes(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await firebasestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        Map<String, dynamic>? savedRecipeIds =
            userDoc.data() as Map<String, dynamic>?;

        // Initialize an empty list to store saved recipes
        List<SavedRecipeModel> savedRecipes = [];

        // If the user has saved recipes, fetch each recipe and add it to the list
        if (savedRecipeIds != null &&
            savedRecipeIds.containsKey('saved_Recipes')) {
          List<dynamic> savedRecipeIdsList =
              savedRecipeIds['saved_Recipes'] as List<dynamic>;
          for (var recipeId in savedRecipeIdsList) {
            DocumentSnapshot recipeDoc =
                await firebasestore.collection('recipes').doc(recipeId).get();
            if (recipeDoc.exists) {
              RecipeModel recipeModel = RecipeModel.fromSnapshot(recipeDoc);
              String recipeUserId = recipeModel.uid;
              DocumentSnapshot userSnapshot = await firebasestore
                  .collection('users')
                  .doc(recipeUserId)
                  .get();
              if (userSnapshot.exists) {
                UserModel userModel = UserModel.fromSnapshot(userSnapshot);
                recipeModel.user = userModel;
                savedRecipes.add(SavedRecipeModel(
                    recipeId: recipeModel.docId!, recipeModel: recipeModel));
              }
            }
          }
        }

        return savedRecipes;
      } else {
        return [];
      }
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
