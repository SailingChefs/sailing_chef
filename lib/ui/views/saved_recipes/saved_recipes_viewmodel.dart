import 'dart:developer';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/saved_recipe_model.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';

class SavedRecipesViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _savedRecipeService = locator<SavedRecipeService>();
  List<SavedRecipeModel> get savedRecipes => _savedRecipeService.savedRecipes;

  String selectedTab = 'All';
  bool isAllSelected = true;
  bool isFollowingSelected = false;
  @override
  List<ListenableServiceMixin> get listenableServices => [_savedRecipeService];

  void allSelected() {
    isAllSelected = true;
    isFollowingSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void onViewModelReady() async {
    setBusy(true);
    await _savedRecipeService.init();

    setBusy(false);
  }

  void followingSelected() {
    isFollowingSelected = true;
    isAllSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void handleTab(int index) {
    switch (index) {
      case 0:
        selectedTab = 'All';
        break;
      case 1:
        selectedTab = 'Following';
        break;

      default:
        break;
    }

    rebuildUi();
  }

  void goBack() {
    log('tapped');
    _navigationService.back();
  }

  void toDishDetailsScreen() {
    // _navigationService.navigateToSavedRecipeDetailsView();
  }
}
