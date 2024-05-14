import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';

class ViewAllDraftsViewModel extends BaseViewModel { 
    final _navigatorService = locator<NavigationService>();
    final _draftService = locator<RecipeService>();
    List<RecipeModel> get draft => _draftService.drafts;
   void settingsView() {
    _navigatorService.back();
  }

  void onViewModelReady() async {
    setBusy(true);
    await _draftService.initializeddraft();
    
    setBusy(false);
  }

  void toDishCreateScreen(int index) {
    _navigatorService.navigateToAddRecipeView(drafts: draft[index]);
  }

  

}
