import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/model/saved_recipe_model.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';
import 'package:stacked/stacked.dart';

class GridTileModel extends ReactiveViewModel {
  final SavedRecipeService _savedRecipeService = locator<SavedRecipeService>();
  @override
  // ignore: override_on_non_overriding_member
  List<ListenableServiceMixin> get savedRecipes => [_savedRecipeService];

   List<SavedRecipeModel> get fetchSavedRecipesList {
    return _savedRecipeService.savedRecipes;
  }
  void onBookmarkTap(String recipeId) {
    _savedRecipeService.addSavedRecipe(SavedRecipeModel(recipeId: recipeId, userId: userDetails!.uid!, docId: ''));
  }
}
