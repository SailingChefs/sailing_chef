import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_viewmodel.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipee_view_widgets/main_container/chef_notes.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipee_view_widgets/main_container/publish_text_button.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipee_view_widgets/main_container/time_serving.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipee_view_widgets/main_container/tips_notes.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipee_view_widgets/main_container/user_details.dart';
import 'package:sailing_chefs/ui/widgets/bottom_sheet_btn.dart';
import 'ingredients_class.dart';
import 'methods.dart';

class MainRecipeViewContainer extends ViewModelWidget<RecipeViewViewModel> {
  final RecipeModel recipeModel;
  final List<XFile?> selectedImages;
  const MainRecipeViewContainer(this.recipeModel, this.selectedImages,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, RecipeViewViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
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
              verticalSpace(12.h),
              TimeAndServing(
                recipeModel: recipeModel,
              ),
              // const TabBarWidgets(),
              verticalSpace(24.h),
              // verticalSpaceTiny,
              IngredientsClass(
                recipeModel,
              ),
              verticalSpace(12),
              Methods(
                recipe: recipeModel,
              ),
              verticalSpace(12),
              TipsNotes(
                viewModel: recipeModel,
              ),
              const ChefNotes(),
              verticalSpace(24),
              const ChefDetail(),
              verticalSpace(12),
              SaveRecipeButton(
                onPressed: () {
                  viewModel.saveRecipe(recipeModel, selectedImages);
                },
                buttonText: 'Publish Recipe',
              ),
              verticalSpace(12),

              PublishTextButton(
                recipe: recipeModel,
                selectedImages: selectedImages,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
