import 'package:flutter_svg/flutter_svg.dart';
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
                fontSize: 14.sp,
                letterSpacing: -0.5,
                fontWeight: FontWeight.w600,
                color: kcBlackColor,
              ),
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
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final instruction = viewModel.methodsList[index];
                      return Padding(
                        padding:  EdgeInsets.only(top: 5.0.h, bottom: 5.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width:
                                  MediaQuery.sizeOf(context).width * 0.78,
                              decoration: BoxDecoration(
                                color: kcPrimaryColor.withOpacity(0.07),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  instruction,
                                  style: globalTextStyle(
                                    fontSize: 12.sp,
                                    letterSpacing: -0.5,
                                    fontWeight: FontWeight.w600,
                                    color: kcBlackColor.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                viewModel.deleteMethod(index);
                              },
                              child: SvgPicture.asset(
                                'assets/images/misc/bin.svg',
                                height: 16.h,
                                width: 14.w,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  verticalSpaceTiny,
                  GestureDetector(
                    onTap: () {
                      // viewModel.callCookingInstructionBottomSheet();
                      List<String> methods = viewModel.methodsList;
                      viewModel.addMethods(methods);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: kcPrimaryColor.withOpacity(0.07),
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
                                size: 16.0.dg,
                              )),
                          horizontalSpaceSmall,
                          Text(
                            'Add one or multiple steps',
                            style: globalTextStyle(
                              fontSize: 12.sp,
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w600,
                              color: kcBlackColor.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : GestureDetector(
                onTap: () {
                  viewModel.callCookingInstructionBottomSheet();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: kcPrimaryColor.withOpacity(0.07),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            color: kcBlackColor.withOpacity(0.5),
                            size: 16.0.dg,
                          )),
                      horizontalSpaceSmall,
                      Text(
                        'Add one or multiple steps',
                        style: globalTextStyle(
                          fontSize: 12.sp,
                          letterSpacing: -0.5,
                          fontWeight: FontWeight.w600,
                          color: kcBlackColor.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
