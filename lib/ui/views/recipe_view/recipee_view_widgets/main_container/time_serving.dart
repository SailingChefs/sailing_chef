import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_viewmodel.dart';

class TimeAndServing extends ViewModelWidget<RecipeViewViewModel> {
  final RecipeModel recipeModel;
  const TimeAndServing({super.key, required this.recipeModel});

  @override
  Widget build(BuildContext context, RecipeViewViewModel viewModel) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: kcPrimaryColorDark.withOpacity(0.2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                FlutterRemix.time_line,
                color: kcBlackColor,
                size: 18.dg,
              ),
              // horizontalSpaceSmall,
              Text(
                ' ${recipeModel.prepTime.trim()}',
                style: globalTextStyle(
                  fontSize: 12.0.sp,
                  color: kcBlackColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        horizontalSpaceSmall,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: kcPrimaryColorDark.withOpacity(0.2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Icon(
                  FlutterRemix.group_line,
                  color: kcPrimaryColor,
                  size: 18.0,
                ),
              ),

              // horizontalSpaceSmall,
              Text(
                ' ${recipeModel.servingSize} servings',
                style: globalTextStyle(
                  fontSize: 12.0.sp,
                  color: kcBlackColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
