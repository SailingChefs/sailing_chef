import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class DiscardSheetModel extends ReactiveViewModel {
  final _navigatorlocator = locator<NavigationService>();
  final _recipeService = locator<RecipeService>();

  final RecipeModel recipe;
  DiscardSheetModel({required this.recipe});

  Future<void> saveButton(
      RecipeModel recipe, List<XFile?> images, String audioNotePath) async {
    List<String> imageUrls;
    imageUrls = images.isNotEmpty
        ? await _recipeService.uploadMediaToFirebase(images, recipe.docId!)
        : [];
    final chefNote = audioNotePath.isNotEmpty
        ? await _recipeService.uploadChefNoteToFirebaseStorage(audioNotePath)
        : '';
    recipe.coverImage.addAll(imageUrls);
    recipe.chefNote = chefNote;

    final saved = await _recipeService.addOrUpdateDraft(recipe);

    if (saved) {
      // await _navigatorlocator.replaceWithViewAllDraftsView();
      _navigatorlocator.back<void>();
    } else {
      showToast(message: 'Error saving draft recipe');
    }
  }

  void discardButton(bool isDraft) {
    if (isDraft) {
      _navigatorlocator.back<void>();
      return;
    }

    _navigatorlocator.navigateToBottomNavBarView();
  }
}
