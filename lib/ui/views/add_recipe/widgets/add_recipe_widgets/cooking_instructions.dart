import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';

class CookingInstructions extends ViewModelWidget<AddRecipeViewModel> {
  const CookingInstructions(this.drafts, {super.key});
  final RecipeModel? drafts;

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
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: kcBlackColor),
            ),
            horizontalSpaceTiny,
            Text(
              '*',
              style: globalTextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: kcErrorColor),
            ),
          ],
        ),
        verticalSpaceSmall,
        viewModel.methodsList.isNotEmpty
            ? Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: viewModel.methodsList.length,
                    itemBuilder: (context, index) {
                      final instruction = viewModel.methodsList[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  // height: 100.h,
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.69,
                                  decoration: BoxDecoration(
                                    color: kcVeryLightGrey.withOpacity(0.2),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      instruction,
                                      style: globalTextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: kcBlackColor.withOpacity(0.5)),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    viewModel.deleteMethod(index);
                                  },
                                  icon: const Icon(
                                    Icons.delete_outline,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      viewModel.callCookingInstructionBottomSheet();
                      List<String> methods = viewModel.methodsList;
                      viewModel.addMethods(methods);
                    },
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: kcVeryLightGrey.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
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
              )
            : GestureDetector(
                onTap: (){
                  viewModel.callCookingInstructionBottomSheet();
                } ,
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
