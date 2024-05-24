import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';

class DiscardSheetModel extends BaseViewModel {
  final _navigatorlocator = locator<NavigationService>();
  final _recipeService = locator<RecipeService>();

  void saveButton(RecipeModel recipe, final images, final path) async {
    List<String> imageUrls;
    imageUrls = images.isNotEmpty
        ? await _recipeService.uploadMediaToFirebase(images, recipe.docId!)
        : [];
    final String chefNote = path.isNotEmpty
        ? await _recipeService.uploadChefNoteToFirebaseStorage(path!)
        : '';
    recipe.coverImage += imageUrls;
    recipe.chefNote = chefNote;

    await _recipeService.addRecipeToFirestore(recipe);
    _navigatorlocator.replaceWithViewAllDraftsView();
  }

  void discardButton() {
    _navigatorlocator.navigateToBottomNavBarView();
  }
}
