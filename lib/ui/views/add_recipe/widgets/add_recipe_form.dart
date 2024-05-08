import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/widgets/ingredients_class.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/chefs_note.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/cooking_instructions.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/cover_picture.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/ingredients.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/prep_time.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/recipe_title.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/serving_quantity_dropdown.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/visibilty.dart';
import 'package:sailing_chefs/ui/widgets/bottom_sheet_btn.dart';

class AddRecipeFormAddRecipeScreen extends ViewModelWidget<AddRecipeViewModel> {
  final List<Ingredient>? ingredientsList;
  const AddRecipeFormAddRecipeScreen(
      this.ingredientsList, this.isfromprofileview,
      {super.key});
  final bool isfromprofileview;
  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return SingleChildScrollView(
        child: Form(
      key: viewModel.formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const RecipeTitle(),
        verticalSpaceMedium,
        const CoverPictureSelector(),
        verticalSpaceSmall,
        const ServingQuantity(),
        verticalSpaceMedium,
        const Ingredients(),
        verticalSpaceMedium,
        const CookingInstructions(),
          verticalSpaceMedium,
        const PrepTime(),
         verticalSpaceMedium,
        const VisibiltyDropDown(),
        verticalSpaceMedium,
        
        const ChefsNote(),
        verticalSpaceMedium,
        SaveRecipeButton(
          onPressed: viewModel.previewRecipe,
          buttonText: 'Preview ',
          postfix: Icons.remove_red_eye_outlined,
        ),
        verticalSpaceMedium,
      ]),
    ));
  }
}
