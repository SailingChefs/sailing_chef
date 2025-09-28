import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/cooking_instructions_sheet_model.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';

class CookingTopBar extends ViewModelWidget<CookingInstructionsSheetModel> {
  const CookingTopBar(this.listIndex, this.isEdit, {super.key});

  final int? listIndex;
  final bool isEdit;

  @override
  Widget build(BuildContext context, CookingInstructionsSheetModel viewModel) {
    return Padding(
      padding: EdgeInsets.all(15.0.dg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BackArrowWidget(onTap: viewModel.popBack),
          GestureDetector(
            onTap: () {
              if (viewModel.instructionsList.isNotEmpty && !isEdit) {
                viewModel.saveData();
              } else {
                viewModel.editInstruction(listIndex!);
              }
            },
            child: Text(
              'Save',
              style: globalTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: viewModel.instructionsList.isEmpty && !isEdit
                      ? Colors.grey.shade300
                      : kcPrimaryColor.withOpacity(0.9)),
            ),
          ),
        ],
      ),
    );
  }
}
