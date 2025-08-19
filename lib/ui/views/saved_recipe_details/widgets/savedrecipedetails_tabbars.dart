import 'package:sailing_chefs/core/imports/core_imports.dart';

import '../saved_recipe_details_viewmodel.dart';

class RecipeViewTabBars extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  const RecipeViewTabBars({super.key});

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Container(
      height: screenHeight(context) * 0.05,
      width: screenWidth(context) * 0.83,
      decoration: BoxDecoration(
        color: kcPrimaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.all(Radius.circular(30.dg)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                viewModel.handleTab(0);
                viewModel.myIngredientsSelected();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.selectedTab == 'Ingredients'
                      ? kcPrimaryColor
                      : Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ingredients',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: viewModel.selectedTab == 'Ingredients'
                            ? kcVeryLightGrey
                            : kcPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                viewModel.handleTab(1);
                viewModel.methodsSelected();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.selectedTab == 'Methods'
                      ? kcPrimaryColor
                      : Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Methods',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: viewModel.selectedTab == 'Methods'
                            ? kcVeryLightGrey
                            : kcPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
