import 'package:flutter/rendering.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/saved_recipes_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/widgets/explore_all_button.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class AllSavedRecipesScreen extends ViewModelWidget<SavedRecipesViewModel> {
  const AllSavedRecipesScreen({super.key});

  @override
  Widget build(BuildContext context, SavedRecipesViewModel viewModel) {
    return viewModel.savedRecipes.isEmpty
        ? const Center(child: Text('No Saved Recipe Found'))
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return ShrinkWrappingViewport(
                    offset: ViewportOffset.zero(),
                    axisDirection: AxisDirection.down,
                    slivers: [
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15.0,
                          mainAxisSpacing: 18.0,
                          childAspectRatio: 7.4 / 9,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return PrimaryGridTile(
                                savedRecipeList: viewModel.savedRecipes,
                                recipeId:
                                    viewModel.savedRecipes[index].recipeId,
                                onTap: () => viewModel.toDishDetailsScreen(
                                    viewModel.savedRecipes[index].recipeModel!),
                                foodImagePath: viewModel
                                    .savedRecipes[index].recipeModel!.coverImage
                                    .where(
                                        (element) => element.contains('.jpg'))
                                    .first,
                                dishName: viewModel
                                    .savedRecipes[index].recipeModel!.title,
                                duration: viewModel
                                    .savedRecipes[index].recipeModel!.prepTime,
                                chefImagePath: viewModel.savedRecipes[index]
                                    .recipeModel!.user!.displayPicture!);
                          },
                          childCount: viewModel.savedRecipes.length,
                        ),
                      ),
                    ],
                  );
                }),
              ),
              verticalSpace(90),
              const ExploreAllButton(),
            ],
          );
  }
}
//
