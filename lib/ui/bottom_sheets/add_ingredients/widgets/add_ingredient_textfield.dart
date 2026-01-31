import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/add_ingredients_sheet_model.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

// ignore: must_be_immutable
class AddIngredientTextField extends ViewModelWidget<AddIngredientsSheetModel> {
  AddIngredientTextField(
      {super.key, this.hintText, this.prefix, this.postfix, this.width});
  final String? hintText;
  final IconData? prefix;
  final IconData? postfix;
  final double? width;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context, AddIngredientsSheetModel viewModel) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            prefix,
            color: kcBlackColor.withOpacity(0.4),
            size: 30.sp,
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: RoundedTransparentTextField(
              controller: viewModel.ingredientNameController,
              fillColor: const Color(0xFF427536).withOpacity(0.04),
              labelText: '$hintText',
              textColor: kcBlackColor.withOpacity(0.4),
            ),
          ),
        ),
      ],
    );
  }
}
