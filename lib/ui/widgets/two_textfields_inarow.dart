// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/add_ingredients_sheet_model.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

class TwoTextFields extends ViewModelWidget<AddIngredientsSheetModel> {
  const TwoTextFields({super.key});

  @override
  Widget build(
      BuildContext context, AddIngredientsSheetModel ingredientviewModel) {
    return Padding(
      padding: const EdgeInsets.only(left:28.0,right:10,top:10,bottom:10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              horizontalSpaceSmall,
              SizedBox(
                width: 190,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: RoundedTransparentTextField(
                    labelText: 'Quality',
                    textColor: kcBlackColor.withOpacity(0.4),
                  ),
                  
                ),
              ),
              horizontalSpaceSmall,
            ],
          ),
          Expanded(
            child: Container(
              height: 50.h,
              width: 190.w,
              decoration: BoxDecoration(
                color: kcVeryLightGrey.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    style: globalTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kcBlackColor.withOpacity(0.4)),
                    isExpanded: true,
                    value: ingredientviewModel.selectedValue.isEmpty
                        ? ' '
                        : ingredientviewModel.selectedValue,
                    onChanged: (String? newValue) {
                      ingredientviewModel.updateValue(newValue!);
                    },
                    items: ingredientviewModel.values.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
