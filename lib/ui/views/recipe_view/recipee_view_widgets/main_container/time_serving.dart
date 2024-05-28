import 'package:flutter_svg/svg.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
          decoration: BoxDecoration(
            color: kcPrimaryColorDark.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             SvgPicture.asset(
                'assets/images/misc/clock.svg',
                width: 18,
                height: 18,
             ),
              // horizontalSpaceSmall,
              Text(
                ' ${recipeModel.prepTime}',
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: kcPrimaryColorDark.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: viewModel.decrementServings,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: const BoxDecoration(
                        color: kcPrimaryColorDark,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: viewModel.decrementServings,
                          child: const Icon(
                            FlutterRemix.subtract_fill,
                            color: kcWhiteColor,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  horizontalSpaceSmall,
                  Text(' ${viewModel.servings} '),
                  horizontalSpaceSmall,
                  GestureDetector(
                    onTap:(){
                      viewModel.incrementServings();
                      viewModel.getUpdatedIngredients();
                    },
                    child: const Icon(
                      FlutterRemix.add_circle_fill,
                      color: kcPrimaryColorDark,
                    ),
                  ),
                ])),
      ],
    );
  }
}
