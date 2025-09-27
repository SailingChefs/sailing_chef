import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class SaveDraftAlertboxDialogModel extends BaseViewModel {
  final _navigatorlocator = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _recipeService = locator<RecipeService>();

  Future<void> yesButton(RecipeModel recipe, List<XFile?> images, String audioNotePath) async {
    List<String> imageUrls;
    log(recipe.docId?.toString() ?? 'No docId found for recipe');
    imageUrls =
        images.isNotEmpty ? await _recipeService.uploadMediaToFirebase(images, recipe.docId!) : [];
    final chefNote = audioNotePath.isNotEmpty
        ? await _recipeService.uploadChefNoteToFirebaseStorage(audioNotePath)
        : '';
    recipe.coverImage += imageUrls;
    recipe.chefNote = chefNote;
    final saved = await _recipeService.addOrUpdateDraft(recipe);

    if (saved) {
      // _navigatorlocator.replaceWithViewAllDraftsView();
      // _navigatorlocator.back();
    } else {
      showToast(message: 'Error saving draft recipe');
    }
  }

  void noButton(RecipeModel model, List<XFile?> selectedImages, String path, bool isDraft) {
    _bottomSheetService.showCustomSheet(variant: BottomSheetType.discard, data: {
      'model': model,
      'images': selectedImages,
      'path': path,
      'isDraft': isDraft,
    });
  }
}
