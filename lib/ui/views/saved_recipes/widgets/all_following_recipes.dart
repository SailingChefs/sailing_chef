import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/saved_recipes_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/widgets/search_bar_following.dart';

import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class FollowingSavedRecipesScreen
    extends ViewModelWidget<SavedRecipesViewModel> {
  const FollowingSavedRecipesScreen({super.key});

  @override
  Widget build(BuildContext context, SavedRecipesViewModel viewModel) {
    return Column(children: [
      const SearchBarSavedRecipesFollowingScreen(),
      verticalSpaceMedium,
      if (viewModel.searchFollowingController.text.isNotEmpty)
        SizedBox(
          height: 500.h,
          child: GridView.builder(
            itemCount: viewModel.searchFollowingRecipes().length,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.h),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 18.0,
              childAspectRatio: 7.4 / 9,
            ),
            itemBuilder: (BuildContext context, int index) {
              final recipe =
                  viewModel.searchFollowingRecipes().elementAt(index);
              return PrimaryGridTile(
                  chefId: recipe.user!.uid!,
                  rating: recipe.rating,
                  recipe: recipe,
                  onTap: () => viewModel.toDishDetailsScreen(recipe),
                  foodImagePath: recipe.coverImage
                      .where((element) => element.contains('.jpg'))
                      .first,
                  dishName: recipe.title,
                  duration: recipe.prepTime,
                  chefImagePath: recipe.user!.displayPicture!);
            },
          ),
        )
      else
        viewModel.followingRecipes.isEmpty
            ? const Center(child: Text('No Following Saved Recipe Found'))
            : SizedBox(
                height: 500.h,
                child: GridView.builder(
                  itemCount: viewModel.followingRecipes.length,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.h),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 18.0,
                    childAspectRatio: 7.4 / 9,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return PrimaryGridTile(
                        chefId: viewModel.followingRecipes[index].user!.uid!,
                        rating: viewModel.followingRecipes[index].rating,
                        recipe: viewModel.followingRecipes[index],
                        onTap: () => viewModel.toDishDetailsScreen(
                            viewModel.followingRecipes[index]),
                        foodImagePath: viewModel
                            .followingRecipes[index].coverImage
                            .where((element) => element.contains('.jpg'))
                            .first,
                        dishName: viewModel.followingRecipes[index].title,
                        duration: viewModel.followingRecipes[index].prepTime,
                        chefImagePath: viewModel
                            .followingRecipes[index].user!.displayPicture!);
                  },
                ),
              ),
    ]);
  }
}
