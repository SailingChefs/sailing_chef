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
import '../saved_recipe_details_viewmodel.dart';

class MainRecipeViewContainer
    extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final RecipeModel recipeModel;
  final List<RecipeModel> recipeList;
  final bool isFromPrivateProfile;
  const MainRecipeViewContainer(
      {Key? key, required this.recipeModel,required this.isFromPrivateProfile, required this.recipeList})
      : super(key: key);

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.dg, vertical: 10.dg),
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

          verticalSpace(16.h),
          ViewProfileRow(
            user: recipeModel.user!,
          ),
          CommentsDetailsScreen(isFromPrivateProfile: isFromPrivateProfile,recipeModel: recipeModel),
          verticalSpace(12),
          BottomSlider(
            isFromPrivateProfile: isFromPrivateProfile,
            recipeList: recipeList,
          ),
        ],
      ),
    );
  }
}
