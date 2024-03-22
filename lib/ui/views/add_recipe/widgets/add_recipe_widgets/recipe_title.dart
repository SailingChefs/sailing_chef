import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

class RecipeTitle extends ViewModelWidget<AddRecipeViewModel> {
  const RecipeTitle({super.key});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Recipe Title',
              style: globalTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kcBlackColor),
            ),
            horizontalSpaceTiny,
            Text(
              '*',
              style: globalTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kcErrorColor),
            ),
          ],
        ),
        verticalSpaceTiny,
        RoundedTransparentTextField(
          controller: viewModel.titleController,
          labelText: 'Give your recipe a name',
          textColor: kcBlackColor.withOpacity(0.5),
        ),
      ],
    );
  }
}
