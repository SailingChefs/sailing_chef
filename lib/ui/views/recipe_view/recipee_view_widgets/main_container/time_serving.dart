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
          height: 45,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: kcPrimaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FlutterRemix.time_line,
                color: kcBlackColor,
                size: 21.dg,
              ),
              horizontalSpaceSmall,
              Text(
                ' ${recipeModel.prepTime}',
                style: globalTextStyle(
                  fontSize: 16.0.sp,
                  color: kcBlackColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        horizontalSpaceMedium,
        Container(
            width: 130,
            height: 45,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kcPrimaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: viewModel.decrementServings,
                    child: Container(
                      height: 20,
                      decoration: const BoxDecoration(
                        color: kcPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: viewModel.decrementServings,
                          child: const Icon(
                            FlutterRemix.subtract_fill,
                            color: kcWhiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(' ${viewModel.servings} '),
                  GestureDetector(
                    onTap: viewModel.incrementServings,
                    child: const Icon(
                      FlutterRemix.add_circle_fill,
                      color: kcPrimaryColor,
                    ),
                  ),
                ])),
      ],
    );
  }
}
