import 'package:sailing_chefs/core/imports/core_imports.dart';

import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_viewmodel.dart';

class TabBarWidgets extends ViewModelWidget<RecipeViewViewModel> {
  const TabBarWidgets({super.key});

  @override
  Widget build(BuildContext context, RecipeViewViewModel viewModel) {
    return Container(
      height: screenHeight(context) * 0.05,
      width: screenWidth(context) * 0.88,
      decoration: BoxDecoration(
        color: kcPrimaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.all(
          Radius.circular(10.dg),
        ),
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
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.dg),
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
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.dg),
                  ),
                  color: viewModel.selectedTab == 'Method'
                      ? kcPrimaryColor
                      : Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Method',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: viewModel.selectedTab == 'Method'
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
