import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';

import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';

class Methods extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final RecipeModel recipe;

  const Methods({required this.recipe, super.key});
  List<Widget> createIngredientWidgets() {
    return [
      for (int i = 0; i < recipe.methods.length; i++)
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 25,
                  width: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E3E5C),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: globalTextStyle(color: kcwhitecolor, fontSize: 12),
                    ),
                  ),
                ),
                horizontalSpaceSmall,
                Flexible(
                  child: Text(
                    capitalizeEachWord(recipe.methods[i]),
                    textAlign: TextAlign.start,
                    style: globalTextStyle(
                      letterSpacing: -0.1,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: kcBlackColor.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ),
            verticalSpaceMedium,
            // verticalSpaceSmall,
          ],
        ),
    ];
  }

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Method',
          style: globalTextStyle(
            fontSize: 15.0.sp,
            fontWeight: FontWeight.w700,
            color: kcBlackColor,
          ),
        ),
        verticalSpaceMedium,
        ...createIngredientWidgets(),
        // verticalSpaceSmall,
      ],
    );
  }
}
