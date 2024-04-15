import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/ingredients_class.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/methods.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/tab_bars_recipe.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/view_profile_row.dart';
import '../saved_recipe_details_viewmodel.dart';

class MainRecipeViewContainer
    extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final RecipeModel recipeModel;
  const MainRecipeViewContainer({Key? key, required this.recipeModel}) : super(key: key);

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
             SizedBox(height: 250.h),
              Container(
                width: double.infinity,
                decoration:  BoxDecoration(
                  color: kcwhitecolor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35.r),
                    topRight: Radius.circular(35.r),
                  ),
                ),
                child: Column(
                  children: [
                    verticalSpaceMedium,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                          capitalizeEachWord  (recipeModel.title),
                            style: globalTextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: kcBlackColor,
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 45,
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Icon(
                                FlutterRemix.time_line,
                                size: 12,
                                color: kcBlackColor.withOpacity(0.5),
                              ),
                              horizontalSpaceTiny,
                               Text(
                                recipeModel.prepTime,
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  color: kcBlackColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(left: 10.0, right: 10, top: 2),
                    //   child: Text(
                    //     'This Healthy Taco Salad is the universal delight of taco night',
                    //     style: globalTextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w300,
                    //       color: kcBlackColor,
                    //     ),
                    //   ),
                    // ),
                    // verticalSpaceSmall,
                     ViewProfileRow(
                      user: recipeModel.user!,

                    ),
                    verticalSpaceMedium,
                    const TabBarWidgets(),
                    verticalSpaceTiny,
                    viewModel.isIngredientsSelected
                        ?  IngredientsClass(recipeModel: recipeModel,)
                        :   Methods(recipe: recipeModel,),
                    verticalSpaceSmall,
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
