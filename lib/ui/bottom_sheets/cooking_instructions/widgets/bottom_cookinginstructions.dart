import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/cooking_instructions_sheet_model.dart';

import '../../../widgets/bottom_sheet_btn.dart';
import '../../../widgets/rounded_tranparent_textfield.dart';

class BottomCookingInstructions
    extends ViewModelWidget<CookingInstructionsSheetModel> {
  const BottomCookingInstructions({super.key});

  @override
  Widget build(BuildContext context, CookingInstructionsSheetModel viewModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 35),
          child: SizedBox(
            width: double.infinity,
            child: RoundedTransparentTextField(
              labelText: 'Add one or multiple steps',
              controller: viewModel.cookingInstructionController,
              fillColor: Color(0xFF427536).withOpacity(0.04),
              textColor: kcBlackColor.withOpacity(0.4),
              prefixIcon: true,
              prefixIconData: Icons.add,
              
            ),
          ),
        ),
        SaveRecipeButton(
          onPressed: viewModel.addInstruction,
          buttonText: 'Step',
          prefix: Icons.add,
          
        ),
      ],
    );
  }
}
