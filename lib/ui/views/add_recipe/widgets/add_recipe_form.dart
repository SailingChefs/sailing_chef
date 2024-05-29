import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/widgets/ingredients_class.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/chefs_notes.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/cooking_instructions.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/cover_picture.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/ingredients.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/prep_time.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/recipe_title.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/serving_quantity_dropdown.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/tags.dart';
import 'package:sailing_chefs/ui/widgets/bottom_sheet_btn.dart';

class AddRecipeFormAddRecipeScreen extends ViewModelWidget<AddRecipeViewModel> {
  final List<Ingredient>? ingredientsList;
  final RecipeModel? drafts;
  const AddRecipeFormAddRecipeScreen(this.drafts, this.ingredientsList,
      {super.key});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return SingleChildScrollView(
        child: Form(
      key: viewModel.formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        RecipeTitle(drafts),
        verticalSpace(20.h),
        CoverPictureSelector(drafts),
        verticalSpace(20.h),
        ServingQuantity(drafts),
        verticalSpace(20.h),
        Ingredients(drafts),
        verticalSpace(20.h),
        CookingInstructions(drafts),
        verticalSpace(20.h),
        PrepTime(drafts),
        verticalSpace(20.h),
        AddFilters(drafts),
        verticalSpace(20.h),
        ChefsNote(drafts),
        verticalSpace(20.h),
        SaveRecipeButton(
          onPressed: viewModel.previewRecipe,
          buttonText: 'Preview ',
          postfix: Icons.remove_red_eye_outlined,
        ),
        verticalSpace(20.h),
      ]),
    ));
  }
}
