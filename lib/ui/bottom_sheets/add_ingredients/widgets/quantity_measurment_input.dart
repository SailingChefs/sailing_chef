import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/add_ingredients_sheet_model.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

class QuantityMeasurmentInput
    extends ViewModelWidget<AddIngredientsSheetModel> {
  final int index;
  const QuantityMeasurmentInput({super.key, required this.index});

  @override
  Widget build(BuildContext context, AddIngredientsSheetModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 160.w,
          height: 56.h,
          child: RoundedTransparentTextField(
            onChanged: (value) => viewModel.setQuantity(value, index),
            textColor: kcBlackColor.withOpacity(0.5),
            controller: viewModel.quantityController,
            labelText: 'Quantity',
          ),
        ),
        Container(
          height: 47.h,
          width: 160.w,
          decoration: BoxDecoration(
            color: kcVeryLightGrey.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
      ],
    );
  }
}
