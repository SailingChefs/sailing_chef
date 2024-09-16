import 'dart:developer';

import 'package:sailing_chefs/model/ingredients_model.dart';
import 'package:stacked/stacked.dart';

import '../../../core/imports/core_imports.dart';

class EditIngredientSheetModel extends BaseViewModel {
  Ingredient ingredient;
  final int listIndex;
  EditIngredientSheetModel(this.ingredient, this.listIndex);

  TextEditingController ingredientNameController = TextEditingController();
  TextEditingController ingredientQuantityController = TextEditingController();
  String ingredientType = '';

  String selectedValue =
      ''; // Make sure this matches one of the items in the values list
  void onViewModelReady() async {
    setBusy(true);
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

  void setValues() {
    ingredient.name = ingredientNameController.text;
    ingredient.quantity = ingredientQuantityController.text;
    ingredient.unit = selectedValue;
  }

  void updateValue(String newValue) {
    selectedValue = newValue;
    // notifyListeners();
    rebuildUi();
  }

  showUpdatedIngredient() {
    log(" Name   :  ${ingredient.name}");
    log(" Quantity   :  ${ingredient.quantity}");
    log(" Unit   :  ${ingredient.unit}");
  }
}
