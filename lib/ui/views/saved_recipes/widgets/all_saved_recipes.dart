import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/saved_recipes_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class AllSavedRecipesScreen extends ViewModelWidget<SavedRecipesViewModel> {
  const AllSavedRecipesScreen({super.key});

  @override
  Widget build(BuildContext context, SavedRecipesViewModel viewModel) {
    return SizedBox(
      height: 500.h,
      child: GridView.builder(
        itemCount: 10,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.h),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 18.0,
          childAspectRatio: 7.4 / 9,
        ),
        itemBuilder: (BuildContext context, int index) {
          return PrimaryGridTile(
              savedRecipeList: viewModel.savedRecipes,
              recipeId: 'recipe id',
              onTap: viewModel.toDishDetailsScreen,
              foodImagePath: 'assets/images/background/onboarding.png',
              dishName: "dish name",
              duration: "30",
              chefImagePath: 'assets/images/icons/chef.jpg');
        },
      ),
    );
  }
}
