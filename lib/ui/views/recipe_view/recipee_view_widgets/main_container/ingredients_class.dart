import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_viewmodel.dart';

class IngredientsClass extends ViewModelWidget<RecipeViewViewModel> {
  final RecipeModel recipeModel;

  const IngredientsClass(
    this.recipeModel, {
    super.key,
  });

  List<Widget> createIngredientWidgets() {
    return [
      for (var ingredient in recipeModel.ingredients)
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${ingredient.quantity} ${ingredient.unit}',
                    style: globalTextStyle(
                      color: kcBlackColor.withOpacity(0.87),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w300,
                    )),
                Text(capitalizeEachWord(ingredient.name),
                    style: globalTextStyle(
                      color: kcBlackColor.withOpacity(0.6),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    )),
                Container(
                  width: 20.0.h,
                  height: 15.0.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: kcBlackColor.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ),
            verticalSpaceSmall,
          ],
        ),
      // Container(
      //   height: 50.0,
      //   decoration: BoxDecoration(
      //     color: const Color(0xFFF3F3F3),
      //     borderRadius: BorderRadius.circular(15.0),
      //   ),
      //   padding: const EdgeInsets.all(10.0),
      //   margin: const EdgeInsets.symmetric(vertical: 5.0),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Text(capitalizeEachWord(ingredient.name),
      //           style: GoogleFonts.poppins(
      //             textStyle: TextStyle(
      //               color: Colors.black,
      //               fontSize: 18.sp,
      //               fontWeight: FontWeight.w500,
      //             ),
      //           )),
      //       Text('${ingredient.quantity} ${ingredient.unit}',
      //           style: GoogleFonts.poppins(
      //             textStyle: TextStyle(
      //               color: Colors.black,
      //               fontSize: 16.sp,
      //               fontWeight: FontWeight.w300,
      //             ),
      //           )),
      //     ],
      //   ),
      // )
    ];
  }

  @override
  Widget build(BuildContext context, RecipeViewViewModel viewModel) {
    var allIngredients = createIngredientWidgets();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Ingredients',
                style: globalTextStyle(
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.w500,
                  color: kcBlackColor,
                )),
            Container(
              height: 20.0.h,
              width: 150.0.w,
              decoration: BoxDecoration(
                color: kcPrimaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'add all to shopping list',
                      style: globalTextStyle(
                          fontSize: 9,
                          color: kcBlackColor,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      width: 10.0.h,
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
            ),
          ],
        ),
        verticalSpaceMedium,
        ...allIngredients
      ],
    );
  }
}
