import 'dart:developer';

import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';

class SearchViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _savedRecipeService = locator<SavedRecipeService>();
  final TextEditingController searchControllerRecipe = TextEditingController();
  final TextEditingController searchControllerChef = TextEditingController();

  List<RecipeModel> get savedRecipes => savedRecipesGlobal;

  String selectedTab = 'All';
  bool isRecipeSelected = true;
  bool isChefsSelected = false;

  List<ListenableServiceMixin> get listenableServices => [_savedRecipeService];

  void allSelected() {
    isRecipeSelected = true;
    isChefsSelected = false;
    notifyListeners();
    rebuildUi();
  }

  Iterable<RecipeModel> searchRecipes(List<RecipeModel> recipes) sync* {
    log('came to search');
    for (var recipe in recipes) {
      if (recipe.title
          .toLowerCase()
          .contains(searchControllerRecipe.text.toLowerCase())) {
        // rebuildUi();
        yield recipe;
      }
    }
  }

  Iterable<UserModel> searchUser(List<UserModel> chef) sync* {
    log('came to search');
    for (var user in chef) {
      if (user.displayName!
          .toLowerCase()
          .contains(searchControllerChef.text.toLowerCase())) {
        // rebuildUi();
        yield user;
      }
    }
  }

  void onViewModelReady() async {
    setBusy(true);
    await _savedRecipeService.init();
    setBusy(false);
  }

  void toAllDishesScreen(
    List<RecipeModel> recipeList,
  ) {
    _navigationService.navigateToExploreAllRecipesView(recipes: recipeList);
  }

  void followingSelected() {
    isChefsSelected = true;
    isRecipeSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void handleTab(int index) {
    switch (index) {
      case 0:
        selectedTab = 'All';
        break;
      case 1:
        selectedTab = 'Following';
        break;

      default:
        break;
    }

    rebuildUi();
  }

  void goBack() {
    log('tapped');
    // _navigationService.replaceWithBottomNavBarView();

    _navigationService.back();
  }

  void toDishDetailsScreen(RecipeModel recipe) {
    _navigationService.navigateToSavedRecipeDetailsView(
        isFromPrivateProfile: false,
        recipeModel: recipe,
        randomRecipeList:
            IndexViewModel.getRandomDishes(recipe, RecipeService.recipes));
  }

  void toChefProfile(UserModel chef) {
    _navigationService.navigateToChefProfileView(user: chef);
  }

  void toAllChefsScreen(List<UserModel> chefList) {
    _navigationService.navigateToAllChefsView(chefList: chefList);
  }

  void toFilterScreen(List<RecipeModel> recipeList) {
    _navigationService.navigateToFilterView();
  }
}
