import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';

class CookingInstructions extends ViewModelWidget<AddRecipeViewModel> {
  const CookingInstructions({super.key});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Cooking Instructions(Method)',
              style: globalTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kcBlackColor),
            ),
            horizontalSpaceTiny,
            Text(
              '*',
              style: globalTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kcErrorColor),
            ),
          ],
        ),
        verticalSpaceTiny,
        viewModel.methodsList.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: viewModel.methodsList.length,
                itemBuilder: (context, index) {
                  final instruction = viewModel.methodsList[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Step ${index + 1}',
                          style: TextStyle(
                              fontSize: 16,
                              color: kcDarkColor.withOpacity(0.4)),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
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
                                viewModel.deleteMethod(index);
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
              )
            : GestureDetector(
                onTap: viewModel.callCookingInstructionBottomSheet,
                child: Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: kcVeryLightGrey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            color: kcBlackColor.withOpacity(0.5),
                          )),
                      horizontalSpaceSmall,
                      Text(
                        'Add one or multiple steps',
                        style: globalTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: kcBlackColor.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
