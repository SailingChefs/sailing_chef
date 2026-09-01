import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/saved_recipes_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/widgets/search_bar_following.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';
import 'package:sailing_chefs/ui/widgets/empty_state.dart';

class FollowingSavedRecipesScreen
    extends ViewModelWidget<SavedRecipesViewModel> {
  const FollowingSavedRecipesScreen({super.key});

  @override
  Widget build(BuildContext context, SavedRecipesViewModel viewModel) {
    return Column(children: [
      const SearchBarSavedRecipesFollowingScreen(),
      verticalSpaceMedium,
      viewModel.searchFollowingController.text.isNotEmpty
          ? SizedBox(
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
                  final RecipeModel recipe =
                      viewModel.searchFollowingRecipes().elementAt(index);
                  return PrimaryGridTile(
                      chefId: recipe.user!.uid!,
                      rating: recipe.rating!,
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
          : viewModel.followingRecipes.isEmpty
              ? const SizedBox(
                  height: 300,
                  child: AppEmptyState(
                    icon: Icons.people_outline,
                    title: 'No recipes from people you follow',
                    subtitle:
                        'Follow chefs to see their saved recipes here.',
                  ),
                )
              : SizedBox(
                  height: 500.h,
                  child: GridView.builder(
                    itemCount: viewModel.followingRecipes.length,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.h),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 18.0,
                      childAspectRatio: 7.4 / 9,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return PrimaryGridTile(
                          chefId: viewModel.followingRecipes[index].user!.uid!,
                          rating: viewModel.followingRecipes[index].rating!,
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
