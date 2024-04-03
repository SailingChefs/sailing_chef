import '../../../core/imports/core_imports.dart';

class SavedRecipeDetailsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  String selectedTab = 'Ingredients';
  bool isIngredientsSelected = true;
  bool isMethodsSelected = false;
  int serves = 1;

  void myIngredientsSelected() {
    isIngredientsSelected = true;
    isMethodsSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void methodsSelected() {
    isMethodsSelected = true;
    isIngredientsSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void move_Back() {
    _navigationService.back();
    notifyListeners();
    
  }

  void moveToChefProfileView() {
    _navigationService.navigateToChefProfileView();
  }

  void handleTab(int index) {
    switch (index) {
      case 0:
        selectedTab = 'Ingredients';
        break;
      case 1:
        selectedTab = 'Method';
        break;

      default:
        break;
    }

    rebuildUi();
  }

  void addServes() {
    serves++;
    rebuildUi();
    notifyListeners();
  }

  void removeServes() {
    if (serves == 0) {
      serves = 0;
    } else {
      serves--;
    }

    rebuildUi();
    notifyListeners();
  }
}
