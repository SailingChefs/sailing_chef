import 'package:sailing_chefs/core/imports/core_imports.dart';

class RecipeViewViewModel extends BaseViewModel {
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

  void moveBack() {
    _navigationService.back();
    
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
