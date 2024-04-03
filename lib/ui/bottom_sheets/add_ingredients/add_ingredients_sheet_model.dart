
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/add_ingredients_sheet.dart';

import 'widgets/ingredients_class.dart';

class AddIngredientsSheetModel extends BaseViewModel {

  final Function(SheetResponse response)? completer;

  AddIngredientsSheetModel(this.completer) ;

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

    if(completer != null) {
      completer!(SheetResponse(confirmed: true,data: AddIngredientsSheetResponse(ingredientsList: ingredientsList)));
    }
  }


  void addIngredientToList() {
    if (selectedValue != '---' && ingredientNameController.text.isNotEmpty) {
      ingredientsList.insert(
          0,
          Ingredient(
              name: ingredientNameController.text,
              unit: selectedValue,
              quantity: quantityController.text));
      quantityController.clear();
      ingredientNameController.clear();
      selectedValue = '---';
      notifyListeners();
    }
  }

  void popBack() {
    _navigationService.back();
  }

  void goToRecipePreview() {
    _navigationService.navigateToRecipeViewView();
  }

  void addIngredients(String name, String quantity, int index) {
    ingredientsList.insert(
        index, Ingredient(name: name, quantity: quantity, unit: '---'));
    notifyListeners();
  }

  void toDishDetailsScreen() {
    _navigationService.back();
  }
}
