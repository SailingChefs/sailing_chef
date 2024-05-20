import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';

class SaveShare extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final RecipeModel recipe;
  const SaveShare({super.key, required this.recipe});

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Row(children: [
      Container(
        height: 35.h,
        width: 35.w,
        decoration: BoxDecoration(
          color: kcWhiteColor.withOpacity(0.7),
          shape: BoxShape.circle,
        ),
        child: Icon(
          FlutterRemix.share_box_line,
          color: kcBlackColor,
          size: 20.0.sp,
        ),
      ),
      horizontalSpaceTiny,
      recipe.user!.uid != userDetails!.uid ? Container(
         height: 35.h,
        width: 35.w,
        decoration: BoxDecoration(
          color: kcWhiteColor.withOpacity(0.7),
          shape: BoxShape.circle,
        ),
        child: viewModel.isRecipeSaved
            ? Icon(
                Icons.bookmark,
                color: kcBlackColor.withOpacity(0.6),
                size: 20.dg,
              )
            : Icon(
                Icons.bookmark_border,
                color: kcBlackColor.withOpacity(0.6),
                size: 20.dg,
              ),
      ):Container(),
    ],);
  }
}
