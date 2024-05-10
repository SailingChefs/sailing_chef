import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/bottom_slider.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/comments.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/ingredients_class.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/leave_comment_bottom.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/methods.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/tab_bars_recipe.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/view_profile_row.dart';
import '../saved_recipe_details_viewmodel.dart';

class MainRecipeViewContainer
    extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final RecipeModel recipeModel;
  final List<RecipeModel> recipeList;
  const MainRecipeViewContainer(
      {Key? key, required this.recipeModel, required this.recipeList})
      : super(key: key);

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: kcwhitecolor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35.r),
              topRight: Radius.circular(35.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0.dg),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpaceMedium,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        capitalizeEachWord(recipeModel.title),
                        style: globalTextStyle(
                          fontSize: 26.45.sp,
                          fontWeight: FontWeight.w500,
                          color: kcBlackColor,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            FlutterRemix.time_line,
                            size: 12,
                            color: kcBlackColor.withOpacity(0.5),
                          ),
                          horizontalSpaceTiny,
                          Text(
                            recipeModel.prepTime,
                            style: globalTextStyle(
                              fontSize: 10.0,
                              color: kcBlackColor,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  verticalSpaceSmall,
                  ViewProfileRow(
                    user: recipeModel.user!,
                  ),
                  verticalSpaceMedium,
                  const TabBarWidgets(),
                  verticalSpaceSmall,
                  viewModel.isIngredientsSelected
                      ? IngredientsClass(
                          recipeModel: recipeModel,
                        )
                      : Methods(
                          recipe: recipeModel,
                        ),
                  CommentsDetailsScreen(recipeModel: recipeModel),
                  LeaveComment(
                    recipeId: recipeModel.docId,
                  ),
                  BottomSlider(
                    recipeList: recipeList,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
