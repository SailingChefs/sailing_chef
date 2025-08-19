import 'package:flutter_svg/svg.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';

class AddFilters extends ViewModelWidget<AddRecipeViewModel> {
  const AddFilters(this.drafts, {super.key});
  final RecipeModel? drafts;
  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add your filter',
          style: globalTextStyle(
            fontSize: 14.sp,
            letterSpacing: -0.5,
            fontWeight: FontWeight.w600,
            color: kcBlackColor,
          ),
        ),
        verticalSpaceSmall,
        if (viewModel.tagsList.isEmpty) GestureDetector(
                onTap: () => viewModel.showTagsSheet(context),
                child: Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: kcPrimaryColor.withOpacity(0.07),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: kcBlackColor.withOpacity(0.5),
                          size: 22.dg,
                        ),
                        horizontalSpaceSmall,
                        Text(
                          'Select a minimum of 2 tags',
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
              ) else FittedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 35.h,
                      width: screenWidth(context) - 50,
                      child: ListView.builder(
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 2.w),
                          padding: EdgeInsets.symmetric(horizontal: 25.dg),
                          decoration: BoxDecoration(
                            color: const Color(0xff427536).withOpacity(0.16),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Center(
                            child: Text(
                              viewModel.tagsList[index],
                              style: globalTextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: kcBlackColor,
                              ),
                            ),
                          ),
                        ),
                        itemCount: viewModel.tagsList.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                      ),
                    ),
                    horizontalSpaceSmall,
                    Container(
                      // height: 50.h,
                      // width: 50.w,
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: kcPrimaryColor.withOpacity(0.06),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                      ),
                      child: GestureDetector(
                          onTap: () => viewModel.showTagsSheet(context),
                          child: SvgPicture.asset(
                            'assets/images/misc/edit.svg',
                          )),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
