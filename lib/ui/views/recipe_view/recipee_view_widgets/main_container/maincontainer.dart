import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/bottom_sheet_btn.dart';
import 'ingredients_class.dart';
import 'methods.dart';
import 'tab_bars_recipe.dart';

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
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: kcBlackColor,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          height: 45,
                          
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                FlutterRemix.time_line,
                                color: kcPrimaryColor,
                                size: 20,
                              ),
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
                  
                    verticalSpaceMedium,
                    const TabBarWidgets(),
                    verticalSpaceTiny,
                    viewModel.isIngredientsSelected
                        ? IngredientsClass(recipeModel,)
                        : Methods(
                            recipe: recipeModel,
                          ),
                    SaveRecipeButton(
                      onPressed: () {
                        viewModel.saveRecipe(recipeModel, selectedImages);
                      },
                      buttonText: 'Submit Recipe',
                    ),
                    horizontalSpaceSmall,
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
