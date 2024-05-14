import 'dart:developer';

import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class SaveDraftAlertboxDialogModel extends BaseViewModel {
  final _navigatorlocator = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _recipeService = locator<RecipeService>();

  void yesButton(RecipeModel recipe, final images, final path) async {
    List<String> imageUrls;
    log(recipe.docId.toString());
    imageUrls = images.isNotEmpty
        ? await _recipeService.uploadMediaToFirebase(images, recipe.docId!)
        : [];
    final String chefNote = path.isNotEmpty
        ? await _recipeService.uploadChefNoteToFirebaseStorage(path!)
        : '';
    recipe.coverImage = imageUrls;
    recipe.chefNote = chefNote;
    bool saved = await _recipeService.addOrUpdateDraft(recipe);
    if (saved) {
      _navigatorlocator.replaceWithSettingsView();
    } else {
      showToast(message: 'Error saving draft recipe');
    }
  }

  void noButton(RecipeModel model, final selectedImages, final path) {
    _bottomSheetService
        .showCustomSheet(variant: BottomSheetType.discard, data: {
      'model': model,
      'images': selectedImages,
      'path': path,
    });
  }
}
