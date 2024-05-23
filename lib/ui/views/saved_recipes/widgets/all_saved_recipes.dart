import 'package:flutter/rendering.dart';
import 'package:sailing_chefs/core/helpers/avergae_calculator.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/saved_recipes_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/widgets/explore_all_button.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class AllSavedRecipesScreen extends ViewModelWidget<SavedRecipesViewModel> {
  const AllSavedRecipesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, SavedRecipesViewModel viewModel) {
    return viewModel.searchSavedController.text.isNotEmpty
        ? Column(
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
                            final RecipeModel recipe = viewModel
                                .searchRecipes(viewModel.savedRecipes,
                                    viewModel.searchSavedController.text)
                                .elementAt(index);
                            return PrimaryGridTile(

                              chefId: viewModel.savedRecipes[index]
                                    .user!.uid!,
                               rating: viewModel.savedRecipes[index].rating!,
                                recipe: recipe,
                                onTap: () => viewModel
                                    .toDishDetailsScreen(recipe),
                                foodImagePath: recipe.coverImage
                                    .where(
                                        (element) => element.contains('.jpg'))
                                    .first,
                                dishName: recipe.title,
                                duration: recipe.prepTime,
                                chefImagePath:
                                    recipe.user!.displayPicture!);
                          },
                          childCount: viewModel
                              .searchRecipes(viewModel.savedRecipes,
                                  viewModel.searchSavedController.text)
                              .length,
                        ),
                      ),
                    ],
                  );
                }),
              ),
              verticalSpace(90),
              const ExploreAllButton(),
            ],

          ):
     viewModel.savedRecipes.isEmpty
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
                              chefId:viewModel.savedRecipes[index]
                                    .user!.uid! ,
                              rating: calculateAverageRating(viewModel.savedRecipes[index].comment!),
                                recipe:
                                    viewModel.savedRecipes[index],
                                onTap: () => viewModel.toDishDetailsScreen(
                                    viewModel.savedRecipes[index]),
                                foodImagePath: viewModel
                                    .savedRecipes[index].coverImage
                                    .where(
                                        (element) => element.contains('.jpg'))
                                    .first,
                                dishName: viewModel
                                    .savedRecipes[index].title,
                                duration: viewModel
                                    .savedRecipes[index].prepTime,
                                chefImagePath: viewModel.savedRecipes[index]
                                    .user!.displayPicture!);
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
