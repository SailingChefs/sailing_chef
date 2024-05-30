import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';

class TimeAndServingRecipeShow
    extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final RecipeModel recipeModel;
  const TimeAndServingRecipeShow({super.key, required this.recipeModel});

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
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
                    onTap: () {
                      viewModel.incrementServings();
                      viewModel.getUpdatedIngredients();
                    },
                    child: const Icon(
                      FlutterRemix.add_circle_fill,
                      color: kcPrimaryColorDark,
                    ),
                  ),
                ])),
        // Container(
        //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        //   decoration: BoxDecoration(
        //     color: kcPrimaryColorDark.withOpacity(0.2),
        //     borderRadius: BorderRadius.circular(30),
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       const Center(
        //         child: Icon(
        //           FlutterRemix.group_line,
        //           color: kcPrimaryColor,
        //           size: 18.0,
        //         ),
        //       ),

        //       // horizontalSpaceSmall,
        //       Text(
        //         ' ${recipeModel.servingSize} servings',
        //         style: globalTextStyle(
        //           fontSize: 12.0.sp,
        //           color: kcBlackColor,
        //           fontWeight: FontWeight.w400,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

      ],
    );
  }
}
