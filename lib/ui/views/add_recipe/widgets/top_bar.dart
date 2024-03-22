import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';

class TopBarAddRecipe extends ViewModelWidget<AddRecipeViewModel> {
  const TopBarAddRecipe({super.key});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 8.0.dg),
          height: 30.h,
          width: 30.w,
          decoration: const BoxDecoration(
            color: kcVeryLightGrey,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back_ios,
            color: kcBlackColor,
            size: 19.sp,
          ),
        ),
        Text(
          'Create Recipe',
          style: globalTextStyle(
              fontSize: 18.0.dg,
              color: kcBlackColor,
              fontWeight: FontWeight.w500),
        ),
        GestureDetector(
          // onTap: () => viewModel.toSettings(),
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
