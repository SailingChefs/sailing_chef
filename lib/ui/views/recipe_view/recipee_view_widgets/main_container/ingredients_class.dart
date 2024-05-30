import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/ingredients_model.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_viewmodel.dart';

class IngredientsClass extends ViewModelWidget<RecipeViewViewModel> {
  final RecipeModel recipeModel;

  const IngredientsClass(
    this.recipeModel, {
    super.key,
  });

  List<Widget> createIngredientWidgets(List<Ingredient> ingredients) {
    return ingredients.map((ingredient) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: ingredient.toString().length > 10 ? 100.w : 150.w,
                child: Text('${ingredient.quantity} ${ingredient.unit}',
                    style: globalTextStyle(
                      color: kcBlackColor.withOpacity(0.87),
                      letterSpacing: -0.3,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              SizedBox(
                width: 150.w,
                child: Text(
                  capitalizeEachWord(ingredient.name),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: globalTextStyle(
                    letterSpacing: -0.3,
                    color: kcBlackColor.withOpacity(0.5),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: 12.0.w,
                height: 12.0.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: kcBlackColor.withOpacity(0.8),
                  ),
                ),
              ),
              horizontalSpaceTiny,
            ],
          ),
          verticalSpaceSmall,
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context, RecipeViewViewModel viewModel) {
    var updatedIngredients = viewModel.getUpdatedIngredients();
    var allIngredients = createIngredientWidgets(updatedIngredients);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ingredients',
              style: globalTextStyle(
                fontSize: 15.0.sp,
                fontWeight: FontWeight.w700,
                color: kcBlackColor,
              ),
            ),
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.0.h, vertical: 8.0.w),
              decoration: BoxDecoration(
                color: kcPrimaryColorDark.withOpacity(0.2),
                borderRadius: BorderRadius.circular(32.0.dg),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'add all to shopping list',
                    style: globalTextStyle(
                      fontSize: 12.sp,
                      color: kcBlackColor,
                      letterSpacing: -0.2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  horizontalSpaceTiny,
                  Container(
                    width: 12.0.w,
                    height: 12.0.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: kcBlackColor.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        verticalSpaceMedium,
        ...allIngredients
      ],
    );
  }
}
