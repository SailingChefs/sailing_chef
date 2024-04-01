import 'package:sailing_chefs/core/imports/core_imports.dart';

import '../cooking_instructions_sheet_model.dart';

class ListViewCookingInstructions
    extends ViewModelWidget<CookingInstructionsSheetModel> {
  const ListViewCookingInstructions({super.key});

  @override
  Widget build(BuildContext context, CookingInstructionsSheetModel viewModel) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: viewModel.instructionsList.length,
      itemBuilder: (context, index) {
        final instruction = viewModel.instructionsList[index];
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Step ${index + 1}',
                style: TextStyle(
                    fontSize: 16, color: kcDarkColor.withOpacity(0.4)),
              ),
              verticalSpaceTiny,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: Container(
                      // height: 100.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                        color: kcVeryLightGrey.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          instruction,
                          style: globalTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: kcBlackColor.withOpacity(0.5)),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      viewModel.deleteInstruction(index);
                    },
                    icon: const Icon(
                      Icons.delete_outline_sharp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
