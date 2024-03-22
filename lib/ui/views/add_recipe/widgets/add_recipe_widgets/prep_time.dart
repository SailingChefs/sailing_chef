import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/custom_textbtn.dart';

class PrepTime extends ViewModelWidget<AddRecipeViewModel> {
  const PrepTime({super.key});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Prep Time',
              style: globalTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kcBlackColor),
            ),
            CustomTextButton(
                onPressed: () {},
                buttonText: 'Set time',
                textColor: kcPrimaryColor),
          ],
        ),
        Text(
          'How long does it take to cook this recipe?',
          style: globalTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: kcBlackColor.withOpacity(0.5)),
        ),
      ],
    );
  }
}
