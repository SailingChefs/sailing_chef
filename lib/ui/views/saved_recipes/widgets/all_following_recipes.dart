import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/saved_recipes_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class FollowingSavedRecipesScreen
    extends ViewModelWidget<SavedRecipesViewModel> {
  const FollowingSavedRecipesScreen({super.key});

  @override
  Widget build(BuildContext context, SavedRecipesViewModel viewModel) {
    return viewModel.followingRecipes.isEmpty ? const Center(child: Text('No Following Saved Recipe Found')) : 
     SizedBox(
      height: 500.h,
      child: GridView.builder(
        itemCount: viewModel.followingRecipes.length,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.h),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 18.0,
          childAspectRatio: 7.4 / 9,
        ),
        itemBuilder: (BuildContext context, int index) {
          return PrimaryGridTile(
              savedRecipeList: viewModel.followingRecipes,
              recipeId: viewModel.followingRecipes[index].recipeId,
              onTap:() => viewModel.toDishDetailsScreen(viewModel.followingRecipes[index].recipeModel!),
              foodImagePath:
                  viewModel.followingRecipes[index].recipeModel!.coverImage.first,
              dishName: viewModel.followingRecipes[index].recipeModel!.title,
              duration: viewModel.followingRecipes[index].recipeModel!.prepTime,
              chefImagePath: viewModel.followingRecipes[index].recipeModel!.user!.displayPicture!);
        },
      ),
    );
  }
}
