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
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: kcBlackColor),
        ),
        verticalSpaceSmall,
        viewModel.tagsList.isEmpty
            ? GestureDetector(
                onTap: () => viewModel.showTagsSheet(context),
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
                        'Select a minimum of 2 tags',
                        style: globalTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: kcBlackColor.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
              )
            : Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 50.h,
                        width: MediaQuery.of(context).size.width * 0.73,
                        child: ListView.builder(
                          itemBuilder: (context, index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 2.w),
                            padding: const EdgeInsets.symmetric(horizontal: 30),
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
                    ],
                  ),
                  Container(
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: const Color(0xff427536).withOpacity(0.16),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: IconButton(
                      onPressed: () => viewModel.showTagsSheet(context),
                      icon: const Icon(
                        Icons.edit_rounded,
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
