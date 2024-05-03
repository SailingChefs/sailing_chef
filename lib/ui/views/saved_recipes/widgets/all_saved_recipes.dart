import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/saved_recipes_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class AllSavedRecipesScreen extends ViewModelWidget<SavedRecipesViewModel> {
  const AllSavedRecipesScreen({super.key});

  @override
  Widget build(BuildContext context, SavedRecipesViewModel viewModel) {
    return viewModel.savedRecipes.isEmpty
        ? const Center(child: Text('No Saved Recipe Found'))
        : SizedBox(
            height: 500.h,
            child: GridView.builder(
              itemCount: viewModel.savedRecipes.length,
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
                    recipeId: viewModel.savedRecipes[index].recipeId,
                    onTap: () => viewModel.toDishDetailsScreen(
                        viewModel.savedRecipes[index].recipeModel!),
                    foodImagePath: viewModel
                        .savedRecipes[index].recipeModel!.coverImage
                        .where((element) => element.contains('.jpg'))
                        .first,
                    dishName: viewModel.savedRecipes[index].recipeModel!.title,
                    duration:
                        viewModel.savedRecipes[index].recipeModel!.prepTime,
                    chefImagePath: viewModel.savedRecipes[index].recipeModel!
                        .user!.displayPicture!);
              },
            ),
          );
  }
}
