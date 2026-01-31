import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/edit_ingredient/edit_ingredient_sheet_model.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

// ignore: must_be_immutable
class EditIngredientTextField
    extends ViewModelWidget<EditIngredientSheetModel> {
  EditIngredientTextField(
      {super.key, this.hintText, this.prefix, this.postfix, this.width});
  final String? hintText;
  final IconData? prefix;
  final IconData? postfix;
  final double? width;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context, EditIngredientSheetModel viewModel) {
    return Row(
      children: [
        Flexible(
          child: RoundedTransparentTextField(
            controller: viewModel.ingredientNameController,
            fillColor: const Color(0xFF427536).withOpacity(0.04),
            labelText: '$hintText',
            textColor: kcBlackColor.withOpacity(0.4),
          ),
        ),
      ],
    );
  }
}
