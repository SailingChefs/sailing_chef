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
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  List<Map<String, dynamic>> fieldDataList = [];

  void setIngredients(String value, index) {
    fieldDataList[index]['ingredient_name'] = value;
  }

  void setQuantity(String value, index) {
    fieldDataList[index]['quantity'] = value;
  }

  void updateValue(String value) {
    selectedValue = value;
    notifyListeners();
    rebuildUi();
  }

  void popBack() {
    _navigationService.back();
  }

  void goToRecipePreview() {
    _navigationService.navigateToRecipeViewView();
  }

  void addField() {
    fieldDataList
        .add({'field1': '', 'field2': '', 'dropdownValue': 'Option 1'});
  }

  void onViewModelReady() {
    setBusy(true);
    fieldDataList.add({'ingredient_name': '', 'quantity': '', 'unit': 'bag'});
    setBusy(false);
  }

  void addIngredients() {}
}
