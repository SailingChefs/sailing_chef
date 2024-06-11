import 'package:flutter_svg/svg.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/ingredients_model.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';

class Ingredients extends ViewModelWidget<AddRecipeViewModel> {
  const Ingredients(this.drafts, {super.key});
  final RecipeModel? drafts;

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Ingredients',
              style: globalTextStyle(
                fontSize: 14.sp,
                letterSpacing: -0.5,
                fontWeight: FontWeight.w600,
                color: kcBlackColor,
              ),
            ),
            horizontalSpaceTiny,
            Text(
              '*',
              style: globalTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: kcErrorColor),
            ),
          ],
        ),
        verticalSpaceSmall,
        viewModel.ingredientsList.isNotEmpty
            ? Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: viewModel.ingredientsList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final ingredient = viewModel.ingredientsList[index];

                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // height: 50,
                                width:
                                    MediaQuery.sizeOf(context).width * 0.75.w,
                                padding: EdgeInsets.all(10.dg),
                                decoration: BoxDecoration(
                                  color: kcPrimaryColor.withOpacity(0.08),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.dg)),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30.0),
                                        child: Text(
                                          '${ingredient.quantity} ${ingredient.unit}',
                                          overflow: TextOverflow.ellipsis,
                                          style: globalTextStyle(
                                            fontSize: 14.sp,
                                            letterSpacing: -0.5,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                kcBlackColor.withOpacity(0.8),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30.0),
                                        child: Text(
                                          textAlign: TextAlign.right,
                                          capitalizeEachWord(ingredient.name),
                                          overflow: TextOverflow.ellipsis,
                                          style: globalTextStyle(
                                              fontSize: 13.sp,
                                              letterSpacing: -0.5,
                                              fontWeight: FontWeight.w400,
                                              color: kcBlackColor
                                                  .withOpacity(0.87)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  viewModel.ingredientsList.removeAt(index);
                                  viewModel.notifyListeners();
                                },
                                child: SvgPicture.asset(
                                  'assets/images/misc/bin.svg',
                                  height: 16.h,
                                  width: 14.w,
                                ),
                              ),
                            ],
                          ),
                          verticalSpaceSmall,
                        ],
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      viewModel.callIngredientsBottomSheet;
                      List<Ingredient> ingredients = viewModel.ingredientsList;
                      viewModel.addIngredients(ingredients);
                    },
                    child: Container(
                      height: 50.h,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: kcPrimaryColor.withOpacity(0.08),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: kcBlackColor.withOpacity(0.5),
                            size: 22.dg,
                          ),
                          horizontalSpaceSmall,
                          Text(
                            'Add Ingredient',
                            style: globalTextStyle(
                              fontSize: 12.sp,
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w600,
                              color: kcBlackColor.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),

                    ),
                  ),
                ],
              )
            : GestureDetector(
                onTap: viewModel.callIngredientsBottomSheet,
                child: Container(
                  // height: 50.h,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: kcPrimaryColor.withOpacity(0.08),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            color: kcBlackColor.withOpacity(0.5),
                            size: 22.dg,
                          )),
                      horizontalSpaceSmall,
                      Text(
                        'Add Ingredient',
                        style: globalTextStyle(
                          fontSize: 12.sp,
                          letterSpacing: -0.5,
                          fontWeight: FontWeight.w600,
                          color: kcBlackColor.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
