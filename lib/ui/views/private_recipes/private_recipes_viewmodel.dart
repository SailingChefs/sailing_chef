import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_view.dart';

class PrivateRecipesViewModel extends BaseViewModel {
  final RecipeService _recipeService = locator<RecipeService>();
  final NavigationService _navigationService = locator<NavigationService>();
  List<RecipeModel>? privateRecipe;
  void onViewModelReady() async {
    setBusy(true);
    privateRecipe = await _recipeService.fetchPrivateRecipes(userDetails!.uid!);
    setBusy(false);
  }

  getBack() {
    _navigationService.back();
  }

  void toDishDetailsScreen(int index, RecipeModel recipeModel) {
    _navigationService.navigateWithTransition(
      SavedRecipeDetailsView(
          isFromPrivateProfile: true,
          recipeModel: recipeModel,
          randomRecipeList: IndexViewModel.getRandomDishes(
              recipeModel, RecipeService.recipes)),
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
      transitionStyle: Transition.downToUp,
    );
  }
}
