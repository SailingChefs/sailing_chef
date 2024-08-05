import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/cooking_instructions_sheet_model.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';

class CookingTopBar extends ViewModelWidget<CookingInstructionsSheetModel> {
  const CookingTopBar({super.key});

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
              if (viewModel.instructionsList.isNotEmpty) {
                viewModel.saveData();
              }
            },
            child: Text(
              'Save',
              style: globalTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: viewModel.instructionsList.isEmpty
                      ? Colors.grey.shade300
                      : kcPrimaryColor.withOpacity(0.9)),
            ),
          ),
        ],
      ),
    );
  }
}
