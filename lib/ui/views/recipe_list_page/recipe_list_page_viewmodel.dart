
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';


class RecipeListPageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final RecipeService _recipeService = locator<RecipeService>();
  List<RecipeModel>? recipes;
  void onViewModelReady() async {
    setBusy(true);
     myRecipesList();
    // recipes =
    //     await _recipeService.fetchRecipesByUID(firebaseAuth.currentUser!.uid);
    
    setBusy(false);
  }
  myRecipesList() async {
    if (RecipeService.recipes.isEmpty) {
      recipes = await _recipeService.fetchRecipesByUID(userDetails!.uid!);
      return;
    } else if (RecipeService.recipes.isNotEmpty) {
      for (var recipe in RecipeService.recipes) {
        if (recipe.uid == userDetails!.uid) {
          recipes!.add(recipe);
        }
      }
    }
  }

  void toHomeView() async {
    await Future.delayed(const Duration(milliseconds: 150));
    _navigationService.back();
  }



  void onPopInvoked(bool didPop) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _navigationService.back(result: true);
  }
}
