import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/bottom_slider.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/chefnotes.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/comments.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/ingredients_class.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/methods.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/time_serving.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/tips_notes.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/view_profile_row.dart';
import 'package:sailing_chefs/ui/views/user_details/widgets/semibio.dart';
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
          height: MediaQuery.of(context).size.height * 0.44,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.56,
          decoration: const BoxDecoration(
            color: kcwhitecolor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.dg, vertical: 10.dg),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    capitalizeEachWord(recipeModel.title),
                    style: globalTextStyle(
                      letterSpacing: -0.5,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: kcBlackColor,
                    ),
                  ),
                  verticalSpace(12),
                  TimeAndServingRecipeShow(recipeModel: recipeModel),
                  verticalSpace(24.h),
                  IngredientsClass(
                    recipeModel: recipeModel,
                  ),
                  verticalSpace(12),
                  Methods(
                    recipe: recipeModel,
                  ),
                  recipeModel.tags!.isEmpty
                      ? Container()
                      : Column(
                          children: [
                            TipsNotesRecipeDetails(viewModel: recipeModel),
                            verticalSpace(12),
                          ],
                        ),
                  const ChefNotesRecipeDetails(),
                  verticalSpace(12),
                  SemiRoundedTranpaentTextFieldBio(
                    labelText: 'Add your own personal note...',
                    controller: viewModel.notesController,
                    fillColor: kcPrimaryColorDark.withOpacity(0.2),
                    textColor: kcBlackColor.withOpacity(0.5),
                  ),
                  verticalSpace(12),
                  ViewProfileRow(
                    user: recipeModel.user!,
                  ),
                  CommentsDetailsScreen(recipeModel: recipeModel),
                  verticalSpace(12),
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
