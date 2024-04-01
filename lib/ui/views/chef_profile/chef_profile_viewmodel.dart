import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../core/imports/core_imports.dart';

class ChefProfileViewModel extends BaseViewModel {
   final _navigationService = locator<NavigationService>();
  String selectedTab = 'Myrecipes';
  bool isMySelected = true;
  bool isSavedSelected = false;

  void myRecipeSelected() {
    isMySelected = true;
    isSavedSelected = false;
    notifyListeners();
    rebuildUi();
  }


  void savedSelected() {
    isSavedSelected = true;
    isMySelected = false;
    notifyListeners();
    rebuildUi();
  }

  void goTogoToProfileEditView(String name) {
    // _navigationService.navigateTo(Routes.followingListView,
    //     arguments: FollowingListView());
  }


  void toSettings() {
    _navigationService.navigateToSettingsView();
  }

  void moveBack() {
    _navigationService.back();
  }


  void handleTab(int index) {
    switch (index) {
      case 0:
        selectedTab = 'Myrecipes';
        break;
      case 1:
        selectedTab = 'Saved';
        break;

      default:
        break;
    }

    rebuildUi();
  }
}
