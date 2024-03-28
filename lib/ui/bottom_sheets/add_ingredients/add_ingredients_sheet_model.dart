import 'package:sailing_chefs/core/imports/core_imports.dart';

class AddIngredientsSheetModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  String selectedValue = 'bag';
  List<String> values = [
    'As needed',
    'bag',
    'block',
    'bottle',
    'box',
    'bulb',
    'bunch',
    'bowl'
  ];
  void updateValue(String value) {
    selectedValue = value;
    notifyListeners();
    rebuildUi();
  }

  void popBack() {
    _navigationService.back();
  }

  void addIngredients() {}
}
