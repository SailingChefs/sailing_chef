import 'dart:developer';

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';

class SaveDraftAlertboxDialogModel extends BaseViewModel {
  final _navigatorlocator = locator<NavigationService>();
  final _recipeService = locator<RecipeService>();

  void yesButton(RecipeModel recipe, final images) async {
    List<String> imageUrls;
    log(recipe.docId.toString());
    imageUrls = images.isNotEmpty
        ? await _recipeService.uploadMediaToFirebase(images, recipe.docId)
        : [];
    recipe.coverImage = imageUrls;
    await _recipeService.addRecipeToFirestore(recipe);
    _navigatorlocator.back();
  }

  void noButton() {
    _navigatorlocator.back();
  }
}
