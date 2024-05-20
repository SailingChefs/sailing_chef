import 'package:flutter/services.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

import '../add_ingredients_sheet_model.dart';
import '../../../widgets/rounded_tranparent_textfield.dart';

class TwoTextFields extends ViewModelWidget<AddIngredientsSheetModel> {
  const TwoTextFields({super.key});

  @override
  Widget build(BuildContext context, AddIngredientsSheetModel viewModel) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 28.0, right: 10, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              horizontalSpaceSmall,
              SizedBox(
                width: 190.w,
                height: 50.h,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: RoundedTransparentTextField(
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    labelText: 'Quantity',
                    controller: viewModel.quantityController,
                    fillColor: const Color(0xFF427536).withOpacity(0.04),
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
                color: const Color(0xFF427536).withOpacity(0.04),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    style: globalTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kcBlackColor.withOpacity(0.4)),
                    isExpanded: true,
                    value: viewModel.selectedValue.isEmpty
                        ? ' '
                        : viewModel.selectedValue,
                    onChanged: (String? newValue) {
                      viewModel.updateValue(newValue!);
                    },
                    items: viewModel.values.map((String value) {
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
