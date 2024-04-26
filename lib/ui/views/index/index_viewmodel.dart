import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/saved_recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/chef_service.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';

class IndexViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _chefService = locator<ChefService>();
  final _recipeService = locator<RecipeService>();
  final _savedRecipeService = locator<SavedRecipeService>();
  List<UserModel>? chefList;
  List<RecipeModel>? dishes;
  List<SavedRecipeModel> get savedRecipes => _savedRecipeService.savedRecipes;

  void goToFilterView() {
    _navigationService.navigateTo(Routes.filterView);
  }

  void onViewModelReady() async {
    setBusy(true);
    chefList = await _chefService.fetchChefDocuments();

    await _savedRecipeService.init();

    dishes = await _recipeService.fetchAllRecipes();

    setBusy(false);
  }

  void toAllChefsView() {
    _navigationService.navigateToAllChefsView(
      chefList: chefList!,
    );
  }

  void toChefProfile(UserModel chef) {
    _navigationService.navigateToChefProfileView(user: chef);
  }

  void toDishDetailsScreen(index) {
    _navigationService.navigateToSavedRecipeDetailsView(
      recipeModel: dishes![index],
    );
  }
}
