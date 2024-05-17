import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';

class RecipeListPageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final RecipeService _recipeService = locator<RecipeService>();
  List<RecipeModel>? recipes;
  void onViewModelReady() async {
    setBusy(true);
    recipes =
        await _recipeService.fetchRecipesByUID(firebaseAuth.currentUser!.uid);
    notifyListeners();
    setBusy(false);
  }

  void toHomeView() {
    _navigationService.replaceWithBottomNavBarView();
  }
}
