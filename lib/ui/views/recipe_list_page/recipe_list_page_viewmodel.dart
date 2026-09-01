import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';

import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/ui/views/bottom_nav_bar/bottom_nav_bar_view.dart';

class RecipeListPageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final bool isFromDraft;
  RecipeListPageViewModel({required this.isFromDraft});
  final RecipeService _recipeService = locator<RecipeService>();
  List<RecipeModel> recipes = [];
  bool hasLoadError = false;

  void onViewModelReady() async {
    await _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    setBusy(true);
    hasLoadError = false;
    try {
      recipes =
          await _recipeService.fetchRecipesByUID(firebaseAuth.currentUser!.uid);
    } catch (_) {
      hasLoadError = true;
    }
    setBusy(false);
  }

  Future<void> refresh() async {
    recipes = [];
    await _loadRecipes();
  }

  // myRecipesList() async {
  //   if (RecipeService.recipes.isEmpty) {
  //     recipes = await _recipeService.fetchRecipesByUID(userDetails!.uid!);
  //     return;
  //   } else if (RecipeService.recipes.isNotEmpty) {
  //     for (var recipe in RecipeService.recipes) {
  //       if (recipe.uid == userDetails!.uid) {
  //         recipes.add(recipe);
  //       }
  //     }
  //   }
  // }
  void toHomeView() async {
    if (isFromDraft) {
      _navigationService.clearStackAndShowView(BottomNavBarView());
      // _navigationService.replaceWithBottomNavBarView();
      return;
    }
    await Future.delayed(const Duration(milliseconds: 150));
    _navigationService.clearStackAndShowView(BottomNavBarView());
  }

  void onPopInvoked(bool didPop) async {
    if (isFromDraft) {
      _navigationService.clearStackAndShowView(BottomNavBarView());
      return;
    }
    await Future.delayed(const Duration(milliseconds: 150));
    _navigationService.back(result: true);
  }

  toDishDetailsScreen(RecipeModel recipe) {
    _navigationService.navigateToSavedRecipeDetailsView(
        recipeModel: recipe, isFromPrivateProfile: false, randomRecipeList: []);
  }
}
