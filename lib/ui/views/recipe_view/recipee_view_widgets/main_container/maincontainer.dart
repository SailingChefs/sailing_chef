import 'package:image_picker/image_picker.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_viewmodel.dart';
import 'ingredients_class.dart';
import 'methods.dart';
import 'tab_bars_recipe.dart';

class MainRecipeViewContainer extends ViewModelWidget<RecipeViewViewModel> {
  final RecipeModel recipeModel;
  final List<XFile?> selectedImages;
  const MainRecipeViewContainer(this.recipeModel, this.selectedImages, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, RecipeViewViewModel viewModel) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: kcwhitecolor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
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
                           capitalizeEachWord (recipeModel.title),
                            style: globalTextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: kcBlackColor,
                            ),
                          ),
                        ),
                        Container(
                          width: 70,
                          height: 45,
                          padding: const EdgeInsets.all(10.0),
                          child:  Row(
                            children: [
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
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, right: 10, top: 2),
                      child: Text(
                        'This Healthy Taco Salad is the universal delight of taco night',
                        style: globalTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: kcBlackColor,
                        ),
                      ),
                    ),
                    verticalSpaceMedium,
                    const TabBarWidgets(),
                    verticalSpaceTiny,
                    viewModel.isIngredientsSelected
                        ?  IngredientsClass(recipeModel, selectedImages)
                        :  Methods(recipeModel: recipeModel,),
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
