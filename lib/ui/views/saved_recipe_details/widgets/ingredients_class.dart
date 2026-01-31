import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/ingredients_model.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';

class IngredientsClass extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final RecipeModel recipeModel;
  const IngredientsClass({required this.recipeModel, super.key});

  List<Widget> createIngredientWidgets(
      List<Ingredient> ingredients, SavedRecipeDetailsViewModel viewModel) {
    return ingredients.map((ingredient) {
      return Column(
        children: [
          SizedBox(height: 16.0.h),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              viewModel.addOneItemToCart(
                  ingredient: ingredient, recipee: recipeModel);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 130.w,
                  child: Row(
                    children: [
                      // Visibility(
                      //   visible: false,
                      //   child: Text('${viewModel.servings} ',
                      //       style: globalTextStyle(
                      //         color: kcBlackColor.withOpacity(0.87),
                      //         letterSpacing: -0.3,
                      //         fontSize: 14.sp,
                      //         fontWeight: FontWeight.w500,
                      //       )),
                      // ),
                      Text(
                        '${viewModel.parseQuantity(ingredient.quantity, ingredient.serving)} ${ingredient.unit}',
                        style: globalTextStyle(
                          color: kcBlackColor.withOpacity(0.87),
                          letterSpacing: -0.3,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Text(
                      //     '${int.parse(ingredient.quantity) * ingredient.serving} ${ingredient.unit}',
                      //     style: globalTextStyle(
                      //       color: kcBlackColor.withOpacity(0.87),
                      //       letterSpacing: -0.3,
                      //       fontSize: 14.sp,
                      //       fontWeight: FontWeight.w500,
                      //     )),
                    ],
                  ),
                ),
                SizedBox(
                  width: 160.w,
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
                  width: 15.0.w,
                  height: 15.0.h,
                  decoration: BoxDecoration(
                    color:
                        //  viewModel.checkShoppingList(ingredient)
                        viewModel.checkSelected(
                                recipee: recipeModel, ingredient: ingredient)
                            ? kcPrimaryColorDark
                            : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: kcPrimaryColorDark,
                    ),
                  ),
                  child:
                      // viewModel.checkShoppingList(ingredient)
                      viewModel.checkSelected(
                              recipee: recipeModel, ingredient: ingredient)
                          ? Icon(
                              Icons.check,
                              color: kcWhiteColor,
                              size: 12.0.sp,
                            )
                          : Container(),
                ),
                horizontalSpaceTiny,
              ],
            ),
          ),
          verticalSpaceSmall,
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    final updatedIngredients =
        viewModel.getUpdatedIngredients(viewModel.servings);
    final allIngredients =
        createIngredientWidgets(updatedIngredients, viewModel);
    // log(updatedIngredients.first.id!);
    // log(recipeModel.ingredients.first.id!);

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
            GestureDetector(
              onTap: () {
                viewModel.addorRemoveAllIIngredients(
                    recipee: recipeModel, servings: viewModel.servings);
                // viewModel.addAllItemsToCart(recipeModel);
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.0.h, vertical: 8.0.w),
                decoration: BoxDecoration(
                  color: kcPrimaryColorDark.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(32.0.dg),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (viewModel.checkShoppingListAll(recipeModel))
                      Text(
                        'remove all',
                        style: globalTextStyle(
                          fontSize: 12.sp,
                          color: kcBlackColor,
                          letterSpacing: -0.2,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    else
                      Text(
                        'add all to shopping list',
                        style: globalTextStyle(
                          fontSize: 12.sp,
                          color: kcBlackColor,
                          letterSpacing: -0.2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    horizontalSpaceSmall,
                    Container(
                      width: 12.0.w,
                      height: 12.0.h,
                      decoration: BoxDecoration(
                        color: viewModel.checkkAllIngredients(
                                recipee: recipeModel)
                            //  viewModel
                            //         .checkShoppingListAll(viewModel.recipeModel)
                            ? kcBlackColor.withOpacity(0.8)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: kcBlackColor.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        verticalSpaceMedium,
        ...allIngredients,
      ],
    );
  }
}
