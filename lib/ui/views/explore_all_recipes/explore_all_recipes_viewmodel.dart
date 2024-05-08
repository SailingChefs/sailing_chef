import 'dart:developer';

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/saved_recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';

class ExploreAllRecipesViewModel extends BaseViewModel {
  final _navigatorService = locator<NavigationService>();
  final TextEditingController searchController = TextEditingController();
  final _recipeService = locator<RecipeService>();
  final _savedRecipeService = locator<SavedRecipeService>();
  List<SavedRecipeModel> get savedRecipes => _savedRecipeService.savedRecipes;

  List<RecipeModel> recipes = [];

  Iterable<RecipeModel> searchRecipes() sync* {
    log('came to search');
    for (var recipe in recipes) {
      if (recipe.title
          .toLowerCase()
          .contains(searchController.text.toLowerCase())) {
        // rebuildUi();
        yield recipe;
      }
    }
  }

  Future<void> onViewModelReady() async {
    setBusy(true);
    recipes = await _recipeService.fetchAllRecipes();
    await _savedRecipeService.init();

    setBusy(false);
  }

  void toHomeView() {
    _navigatorService.navigateTo(Routes.indexView);
  }

  toDishDetailsScreen(RecipeModel recip) {
    _navigatorService.navigateToSavedRecipeDetailsView(
      recipeModel: recip,
      recipeList: IndexViewModel.getRandomDishes(recip, recipes),
      );
  }
}
