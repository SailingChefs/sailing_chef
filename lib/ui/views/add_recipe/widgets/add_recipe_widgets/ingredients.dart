import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/widgets/ingredients_class.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';

class Ingredients extends ViewModelWidget<AddRecipeViewModel> {
  final List<Ingredient>? ingredientsList ;
  const Ingredients(this.ingredientsList, {super.key});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Ingredients',
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
        GestureDetector(
          onTap: viewModel.callIngredientsBottomSheet,
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: kcVeryLightGrey.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      color: kcBlackColor.withOpacity(0.5),
                    )),
                horizontalSpaceSmall,
                Text(
                  'Add Ingredient',
                  style: globalTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kcBlackColor.withOpacity(0.5)),
                ),
              ],
            ),
          ),
        ),
        verticalSpaceMedium,
      ],
    );
  }
}
