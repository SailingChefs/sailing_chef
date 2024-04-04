import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';

class TopBarAddRecipe extends ViewModelWidget<AddRecipeViewModel> {
  const TopBarAddRecipe({super.key});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackArrowWidget(
          onTap: 
            viewModel.popBack
        ,
        ),
        Text(
          'Create Recipe',
          style: globalTextStyle(
              fontSize: 18.0.dg,
              color: kcBlackColor,
              fontWeight: FontWeight.w500),
        ),
        GestureDetector(
          onTap: viewModel.draftRecipe,
          child: Icon(
            Icons.file_copy,
            color: kcPrimaryColor,
            size: 24.sp,
          ),
        ),
      ],
    );
  }
}
