import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class DiscardSheetModel extends ReactiveViewModel {
  final _navigatorlocator = locator<NavigationService>();
  final _recipeService = locator<RecipeService>();

  final RecipeModel recipe;
  DiscardSheetModel({required this.recipe});

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

    bool saved = await _recipeService.addOrUpdateDraft(recipe);

    if (saved) {
      _navigatorlocator.replaceWithViewAllDraftsView();
    } else {
      showToast(message: 'Error saving draft recipe');
    }
  }

  void discardButton() {
    _navigatorlocator.navigateToBottomNavBarView();
  }
}
