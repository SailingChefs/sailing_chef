import 'dart:developer';

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
    log("mainrecipeview: ${recipeModel.docId}");
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
              padding:
                  EdgeInsets.symmetric(horizontal: 20.0.dg, vertical: 10.dg),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      capitalizeEachWord(recipeModel.title),
                      style: globalTextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: kcBlackColor,
                      ),
                    ),
                    verticalSpaceSmall,
                    TimeAndServing(
                      recipeModel: recipeModel,
                    ),
                    // const TabBarWidgets(),
                    verticalSpaceMedium,
                    // verticalSpaceTiny,
                    IngredientsClass(
                      recipeModel,
                    ),
                    verticalSpaceLarge,
                    Methods(
                      recipe: recipeModel,
                    ),
                    verticalSpaceSmall,
                    TipsNotes(
                      viewModel: recipeModel,
                    ),
                    const ChefNotes(),
                    verticalSpaceLarge,
                    const ChefDetail(),
                    verticalSpaceMedium,
                    SaveRecipeButton(
                      onPressed: () {
                        viewModel.saveRecipe(recipeModel, selectedImages);
                      },
                      buttonText: 'Publish Recipe',
                    ),
                    verticalSpaceMedium,

                    PublishTextButton(
                      recipe: recipeModel,
                      selectedImages: selectedImages,
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
