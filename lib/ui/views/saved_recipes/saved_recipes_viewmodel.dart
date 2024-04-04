import 'package:sailing_chefs/core/imports/core_imports.dart';

class SavedRecipesViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  String selectedTab = 'All';
  bool isAllSelected = true;
  bool isFollowingSelected = false;
  void allSelected() {
    isAllSelected = true;
    isFollowingSelected = false;
    notifyListeners();
    rebuildUi();
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
    _navigationService.back();
  }

  void toDishDetailsScreen() {
    _navigationService.navigateToSavedRecipeDetailsView();
  }
}
