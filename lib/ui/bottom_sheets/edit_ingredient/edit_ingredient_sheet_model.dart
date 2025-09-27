import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/ingredients_model.dart';

class EditIngredientSheetModel extends BaseViewModel {
  Ingredient ingredient;
  // final int listIndex;
  final Function(SheetResponse response)? completer;

  EditIngredientSheetModel(
    this.ingredient,
    this.completer,
  );

  TextEditingController ingredientNameController = TextEditingController();
  TextEditingController ingredientQuantityController = TextEditingController();
  String ingredientType = '';

  String selectedValue = ''; // Make sure this matches one of the items in the values list

  void onViewModelReady() {
    setBusy(true);
    ingredientNameController.text = ingredient.name;
    ingredientQuantityController.text = ingredient.quantity;

    selectedValue = ingredient.unit;
    setBusy(false);

    rebuildUi();
  }

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
  ]; // Example values
  void updateValue(String value) {
    selectedValue = value;
    notifyListeners();
    rebuildUi();
  }

  void onSaved() {
    completer?.call(SheetResponse(
      confirmed: true,
      data: Ingredient(
          id: ingredient.id,
          name: ingredientNameController.text,
          quantity: ingredientQuantityController.text,
          unit: selectedValue,
          serving: ingredient.serving),
    ));
  }
}
