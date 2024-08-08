// ignore_for_file: must_be_immutable

import 'package:flutter/services.dart';
import 'package:sailing_chefs/model/ingredients_model.dart';
import '../../../../core/imports/core_imports.dart';
import '../../../widgets/rounded_tranparent_textfield.dart';
import '../edit_ingredient_sheet_model.dart';

class TwoFields extends ViewModelWidget<EditIngredientSheetModel> {
  final Ingredient ingredient;
  TextEditingController quantityController;
  TwoFields(this.quantityController, this.ingredient, {super.key});

  @override
  Widget build(BuildContext context, EditIngredientSheetModel viewModel) {
    // Ensure the selected value is in the list of values
    if (!viewModel.values.contains(viewModel.selectedValue) &&
        viewModel.values.isNotEmpty) {
      viewModel.selectedValue = viewModel.values.first;
    }

    return Padding(
      padding:
          const EdgeInsets.only(left: 28.0, right: 10, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150.w, // Provide specific width
            height: 50.h,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: RoundedTransparentTextField(
                controller: quantityController,
                keyboardType: TextInputType.datetime,
                maxLength: 3,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                  LengthLimitingTextInputFormatter(3),
                ],
                labelText: 'Quantity',
                fillColor: const Color(0xFF427536).withOpacity(0.04),
                textColor: kcBlackColor.withOpacity(0.4),
              ),
            ),
          ),
          Container(
            height: 50.h,
            width: 150.w, // Provide specific width
            decoration: BoxDecoration(
              color: const Color(0xFF427536).withOpacity(0.04),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  style: globalTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kcBlackColor.withOpacity(0.4),
                  ),
                  isExpanded: true,
                  value: viewModel.selectedValue, 
                  //     ? null
                  //     : viewModel.selectedValue,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      viewModel.updateValue(newValue);
                    }
                  },
                  items: viewModel.values
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
