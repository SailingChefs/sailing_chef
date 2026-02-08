import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/cooking_instructions_sheet_model.dart';
import 'package:sailing_chefs/ui/widgets/bottom_sheet_btn.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

class BottomCookingInstructions extends ViewModelWidget<CookingInstructionsSheetModel> {
  const BottomCookingInstructions(this.method, this.index, {super.key});

  final String? method;
  final int? index;

  @override
  Widget build(BuildContext context, CookingInstructionsSheetModel viewModel) {
    final isEdit = method != null && index != null;
    viewModel.cookingInstructionController.text = isEdit ? method! : '';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 35, bottom: 10),
          child: SizedBox(
            width: double.infinity,
            child: RoundedTransparentTextField(
              labelText: 'Add one or multiple steps',
              controller: viewModel.cookingInstructionController,
              fillColor: const Color(0xFF427536).withOpacity(0.04),
              textColor: kcBlackColor.withOpacity(0.4),
              prefixIcon: true,
              prefixIconData: isEdit ? Icons.edit : Icons.add,
            ),
          ),
        ),
        if (!isEdit)
          SaveRecipeButton(
            onPressed: viewModel.addInstruction,
            buttonText: 'Step',
            prefix: Icons.add,
          ),
      ],
    );
  }
}
