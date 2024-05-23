import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/chef_service.dart';
import 'package:sailing_chefs/services/cullinaryschool_service.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_view.dart';

class IndexViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _chefService = locator<ChefService>();
  final recipeService = locator<RecipeService>();
  final _savedRecipeService = locator<SavedRecipeService>();
  final _cullinaryService = locator<CullinaryschoolService>();
  List<UserModel> get chefList => _chefService.chefs;
  List<UserModel> get cullinary => _cullinaryService.cullinaryscools;

  List<RecipeModel> get dishes => RecipeService.recipes;
  bool isMySelected = true;
  bool isSavedSelected = false;
  String selectedTab = 'Yacht Chefs';
  List<RecipeModel> get savedRecipes => _savedRecipeService.savedRecipes;
  @override
  // ignore: override_on_non_overriding_member
  List<ListenableServiceMixin> get listenableServices =>
      [_savedRecipeService, recipeService, _cullinaryService, _chefService];

  get toViewCullinarySchool => null;

  void goToFilterView() {
    _navigationService.navigateTo(Routes.filterView);
  }

  static List<RecipeModel> getRandomDishes(
      RecipeModel currentRecipe, List<RecipeModel> allRecipes) {
    // Create a copy of allRecipes
    List<RecipeModel> dishes = List.from(allRecipes);
    // Remove the current recipe from the list
    dishes.removeWhere((recipe) => recipe.docId == currentRecipe.docId);

    // Shuffle the list
    dishes.shuffle();
    log(dishes.length.toString());

    // Take the first 5 elements if there are more than 5 dishes, otherwise return all dishes
    return dishes.length > 5 ? dishes.sublist(0, 5) : dishes;
  }




  void onViewModelReady() async {

    if (isInitialised == null) {
      // setBusy(true);
      showShimmer = true;
      await Future.wait([
        _cullinaryService.culinaryInit(),
        _chefService.chefInit(),
        _recipeService.initialized(),
      ]);
      matchAndAssignUsersToDishes();

      isInitialised = true;
      showShimmer = false;
      notifyListeners();
      rebuildUi();

      // setBusy(false);
    } else if (isInitialised == true) {
      return;
    }

  }

  void toAllChefsView() {
    _navigationService.navigateToAllChefsView(
      chefList: chefList,
    );
  }

  void yatchSelected() {
    isMySelected = true;
    isSavedSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void savedSelected() async {
    isSavedSelected = true;

    isMySelected = false;
    notifyListeners();
    rebuildUi();
  }

  void toAllRecipesView() {
    _navigationService.navigateToExploreAllRecipesView(
      recipes: dishes,
    );
  }

  // void setUserProfile() {
  //   if (chefList.isEmpty) {
  //     _chefService.chefInit();
  //   } else {
  //     for (var chef in chefList) {
  //       // Iterate through each recipe associated with the chef
  //       for (var chefRecipe in chef.recipes!) {
  //         // Find the matching recipe in the recipesList by doc_id
  //         var matchingRecipe = dishes.firstWhere(
  //           (recipe) => recipe.docId == chefRecipe.toString(),
  //         );

  //         // If a matching recipe is found
  //         if (matchingRecipe != null) {
  //           // Assign the ChefModel to the user model of the matching recipe
  //           if (matchingRecipe.user == null) {
  //             matchingRecipe.user =
  //                 chef; // Provide appropriate name for UserModel
  //           } else {
  //             matchingRecipe.user = chef;
  //           }
  //         }
  //       }
  //     }
  //   }
  // }
  void matchAndAssignUsersToDishes() {
  // Combine both user lists into one for easier searching
  List<UserModel> allUsers = [...chefList, ...cullinary];

  for (int i = 0 ; i<dishes.length; i++) {

    if (dishes[i].user == null) {
      // Find the matching user in the allUsers list
      UserModel? matchingUser = allUsers.firstWhere(
        (user) => user.uid == dishes[i].uid,
        orElse: () => UserModel(uid: ''),
      );
      if (matchingUser.uid != null) {
        // Assign the matching user to the corresponding dish
        dishes[i].user = matchingUser;
        if(userDetails!.uid == dishes[i].uid){
        dishes[i].user = userDetails!;
      }

      }
    }
  }
  }



  void toChefProfile(UserModel chef) {
    if (chef.uid == FirebaseAuth.instance.currentUser!.uid) {
      _navigationService.navigateToChefProfileView(user: chef);
    } else {
      _navigationService.navigateToChefProfileView(
        user: chef,
      );
    }
  }

  void toDishDetailsScreen(index) {

    _navigationService.navigateWithTransition(
      SavedRecipeDetailsView(recipeModel:  dishes[index],
        randomRecipeList: IndexViewModel.getRandomDishes( dishes[index], dishes)),
     
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
      transitionStyle: Transition.downToUp,
    
     
      
    );
  }

  void handleTab(int index) {
    switch (index) {
      case 0:
        selectedTab = 'Yacht Chefs';
        break;
      case 1:
        selectedTab = 'Culinary School';
        break;

      default:
        break;
    }

    rebuildUi();
  }

  void toViewCullinarySchools() {
    _navigationService.navigateToCulineryschoolviewallView();
  }

  void toSearch() {
    _navigationService.navigateToSearchView(
      chefList: chefList,
      recipeModel: dishes,
    );
  }
}