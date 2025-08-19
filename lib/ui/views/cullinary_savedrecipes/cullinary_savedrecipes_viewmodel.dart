import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_view.dart';

class CullinarySavedrecipesViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final usrService = locator<UserServices>();
  final _savedRecipeService = locator<SavedRecipeService>();
  final bottomsheetService = locator<BottomSheetService>();
  List<RecipeModel> savedRecipes = savedRecipesGlobal;

  @override
  List<ListenableServiceMixin> get listenableServices => [_savedRecipeService];

  Future<void> toDishDetailsScreen(int index, RecipeModel recipeModel) async {
    await _navigationService.navigateWithTransition(
      SavedRecipeDetailsView(
          isFromPrivateProfile: false,
          recipeModel: recipeModel,
          randomRecipeList: IndexViewModel.getRandomDishes(
              recipeModel, RecipeService.recipes)),
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
      transitionStyle: Transition.downToUp,
    );
  }

  Future<void> getBack() async {
    _navigationService.back();
  }
}
