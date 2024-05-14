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
  final _savedRecipeService = locator<SavedRecipeService>();
  List<SavedRecipeModel> get savedRecipes => _savedRecipeService.savedRecipes;


  Iterable<RecipeModel> searchRecipes(List<RecipeModel> recipes) sync* {
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
    await _savedRecipeService.init();

    setBusy(false);
  }

  void toHomeView() {
    _navigatorService.navigateTo(Routes.indexView);
  }

  toDishDetailsScreen(RecipeModel recip) {
    _navigatorService.navigateToSavedRecipeDetailsView(
      recipeModel: recip,
      randomRecipeList: IndexViewModel.getRandomDishes(recip, RecipeService.recipes),
    );
  }
}
