
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/add_recipe_widgets/addrecipe_chefnnote.dart';

class ChefsNoteNew extends ViewModelWidget<AddRecipeViewModel> {
  const ChefsNoteNew( {super.key});
  // final RecipeModel? drafts;
  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
       const AddRecipeChefsNote()
      ],
    );
  }
}
