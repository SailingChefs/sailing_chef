import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/main.dart';
import 'package:sailing_chefs/model/ingredients_model.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/add_ingredients_sheet.dart';

class AddIngredientsSheetModel extends BaseViewModel {
  final Function(SheetResponse response)? completer;

  AddIngredientsSheetModel(this.completer);

  final _navigationService = locator<NavigationService>();
  String selectedValue = '---';
  final quantityController = TextEditingController();
  final ingredientNameController = TextEditingController();

  List<String> values = [
    '---',
    'As needed',
    'bag',
    'block',
    'bottle',
    'box',
    'bulb',
    'bunch',
    'bowl'
  ];
  List<Ingredient> ingredientsList = [];

  void updateValue(String value) {
    selectedValue = value;
    notifyListeners();
    rebuildUi();
  }

  void onSaved() {
    if (completer != null && ingredientsList.isNotEmpty) {
      completer!(SheetResponse(
          confirmed: true,
          data: AddIngredientsSheetResponse(ingredientsList: ingredientsList)));
    }
  }

  void addIngredientToList() {
    if (selectedValue != '---' &&
        ingredientNameController.text.isNotEmpty &&
        quantityController.text.isNotEmpty) {
      ingredientsList.insert(
          0,
          Ingredient(
              serving: 1,
              name: ingredientNameController.text,
              unit: selectedValue,
              quantity: quantityController.text,
              id: uuid.v4()));
      quantityController.clear();
      ingredientNameController.clear();
      selectedValue = '---';
      notifyListeners();
    }
  }

  void popBack() {
    _navigationService.back();
  }

  void addIngredients(String name, String quantity, int index) {
    ingredientsList.insert(
        index,
        Ingredient(
            serving: 1, name: name, quantity: quantity, unit: '---', id: ''));
    notifyListeners();
  }

  void toDishDetailsScreen() {
    _navigationService.back();
  }

  void back() {
    _navigationService.back();
  }
}
