import 'dart:developer';

import 'package:sailing_chefs/model/ingredients_model.dart';
import 'package:stacked/stacked.dart';

import '../../../core/imports/core_imports.dart';

class EditIngredientSheetModel extends BaseViewModel {
  final Ingredient request;

  EditIngredientSheetModel(this.request);
  String selectedValue =
      ''; // Make sure this matches one of the items in the values list
  void onViewModelReady() async {
    setBusy(true);
    selectedValue = request.unit;
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

  void updateValue(String newValue) {
    selectedValue = newValue;
    // notifyListeners();
    rebuildUi();
  }

  showUpdatedIngredient() {
    log(" Name   :  ${request.name}");
    log(" Quantity   :  ${request.quantity}");
    log(" Unit   :  ${request.unit}");
  }
}
