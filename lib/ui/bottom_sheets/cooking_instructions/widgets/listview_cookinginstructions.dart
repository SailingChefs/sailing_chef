import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/cooking_instructions_sheet_model.dart';

class ListViewCookingInstructions extends ViewModelWidget<CookingInstructionsSheetModel> {
  const ListViewCookingInstructions({required this.listIndex, super.key});

  final int listIndex;

  @override
  Widget build(BuildContext context, CookingInstructionsSheetModel viewModel) {
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.instructionsList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final instruction = viewModel.instructionsList[index];
          return Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 5, bottom: 5),
            child: Align(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Step ${index + listIndex + 1}',
                    style: TextStyle(fontSize: 14, color: kcDarkColor.withOpacity(0.4)),
                  ),
                  verticalSpaceTiny,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Container(
                          width: 300.w,
                          decoration: BoxDecoration(
                            color: kcVeryLightGrey.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                textAlign: TextAlign.start,
                                instruction.capitalize(),
                                style: globalTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: kcBlackColor.withOpacity(0.5)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          viewModel.deleteInstruction(index);
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
