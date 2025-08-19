import 'dart:developer';

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';

class ViewAllDraftsViewModel extends BaseViewModel {
  final _navigatorService = locator<NavigationService>();
  final _draftService = locator<RecipeService>();
  List<RecipeModel> get draft => _draftService.drafts;
  void settingsView() {
    _navigatorService.navigateToSettingsView();
  }

  Future<void> onViewModelReady() async {
    setBusy(true);
    await _draftService.initializeddraft();

    setBusy(false);
  }

  Future<void> toDishCreateScreen(int index) async {
    log('toDishCreateScreen');
    await _navigatorService.navigateToAddRecipeView(drafts: draft[index]);
    log(index.toString());
    notifyListeners();
  }
}
