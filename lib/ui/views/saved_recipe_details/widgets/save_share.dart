

import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';

class SaveShare extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final RecipeModel recipe;
  const SaveShare(
      {super.key, required this.isFromPrivateProfile, required this.recipe});
  final bool isFromPrivateProfile;
  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Row(
      children: [
        isFromPrivateProfile == false
            ? GestureDetector(
                onTap: () {
                  viewModel.showSocialIconsBottomSheet();
                },
                child: Container(
                  height: 35.h,
                  width: 35.w,
                  decoration: const BoxDecoration(
                    color: kcsgreycolor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    FlutterRemix.share_box_line,
                    color: kcBlackColor,
                    size: 20.0.sp,
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  viewModel.publicRecipe(recipe);
                },
                child: Container(
                  height: 35.h,
                  width: 35.w,
                  decoration: const BoxDecoration(
                    color: kcsgreycolor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_open_outlined,
                    color: kcBlackColor,
                    size: 20.0.sp,
                  ),
                ),
              ),
        horizontalSpaceTiny,
        recipe.user!.uid != userDetails!.uid
            ? GestureDetector(
                onTap: () {
                  viewModel.thisRecipeSaved(
                    recipe,
                  );
                },
                child: Container(
                  height: 35.h,
                  width: 35.w,
                  decoration: const BoxDecoration(
                    color: kcsgreycolor,
                    shape: BoxShape.circle,
                  ),
                  child: userDetails!.savedRecipes!.contains(recipe.docId)
                      ? Icon(
                          Icons.bookmark,
                          color: kcBlackColor,
                          size: 20.dg,
                        )
                      : Icon(
                          Icons.bookmark_border,
                          color: kcBlackColor,
                          size: 20.dg,
                        ),
                ),
              )
            : Container(),
      ],
    );
  }
}
