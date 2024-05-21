import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

class RecipeTitle extends ViewModelWidget<AddRecipeViewModel> {
  const RecipeTitle(this.drafts, {super.key});
  final RecipeModel? drafts;
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
                  fontSize: 14.sp,
                  letterSpacing: -0.5,
                  fontWeight: FontWeight.w600,
                  color: kcBlackColor,
                  ),
            ),
            horizontalSpaceTiny,
            Text(
              '*',
              style: globalTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: kcErrorColor),
            ),
          ],
        ),
        verticalSpaceTiny,
        RoundedTransparentTextField(
          controller: viewModel.titleController,
          labelText: 'Give your recipe a name',
          validator: viewModel.validateTitle,
          style: globalTextStyle(fontSize: 12.dg,color: kcBlackColor.withOpacity(0.8.dg),fontWeight: FontWeight.w500,letterSpacing: -0.5),
        
          fillColor:   kcPrimaryColor.withOpacity(0.08),
          textColor: kcBlackColor.withOpacity(0.6), 
        ),
      ],
    );
  }
}
