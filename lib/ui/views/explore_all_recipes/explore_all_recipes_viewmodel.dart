import 'dart:developer';

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';

class ExploreAllRecipesViewModel extends BaseViewModel {
  final _navigatorService = locator<NavigationService>();
  final TextEditingController searchController = TextEditingController();
  final _savedRecipeService = locator<SavedRecipeService>();
  List<RecipeModel> get savedRecipes => _savedRecipeService.savedRecipes;

  Iterable<RecipeModel> searchRecipes(List<RecipeModel> recipes) sync* {
    log('came to search');
    for (final recipe in recipes) {
      if (recipe.title
          .toLowerCase()
          .contains(searchController.text.toLowerCase())) {
        // rebuildUi();
        yield recipe;
      }
    }
  }

  void onViewModelReady() {
    setBusy(true);
    // await _savedRecipeService.init();

    setBusy(false);
  }

  void toHomeView() {
    _navigatorService.back();
  }

  void toFilterView() {
    _navigatorService.navigateToFilterView();
  }

  void toDishDetailsScreen(RecipeModel recip) {
    _navigatorService.navigateToSavedRecipeDetailsView(
      isFromPrivateProfile: false,
      recipeModel: recip,
      randomRecipeList:
          IndexViewModel.getRandomDishes(recip, RecipeService.recipes),
    );
  }
}
