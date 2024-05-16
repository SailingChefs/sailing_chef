import 'package:flutter/rendering.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/helpers/avergae_calculator.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/search/search_viewmodel.dart';
import 'package:sailing_chefs/ui/views/search/widgets/explore_all_buttons.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class RecipeScreen extends ViewModelWidget<SearchViewModel> {
  final List<RecipeModel> recipes;
  const RecipeScreen({super.key, required this.recipes});

  @override
  Widget build(BuildContext context, SearchViewModel viewModel) {
    return viewModel.searchControllerRecipe.text.isNotEmpty
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
                                .searchRecipes(recipes)
                                .elementAt(index);
                            return PrimaryGridTile(
                                rating: calculateAverageRating(recipe.comment!),
                                savedRecipeList: viewModel.savedRecipes,
                                recipeId: recipe.docId!,
                                onTap: () =>
                                    viewModel.toDishDetailsScreen(recipe),
                                foodImagePath: recipe.coverImage
                                    .where(
                                        (element) => element.contains('.jpg'))
                                    .first,
                                dishName: recipe.title,
                                duration: recipe.prepTime,
                                chefImagePath: recipe.user!.displayPicture!);
                          },
                          childCount: viewModel.searchRecipes(recipes).length,
                        ),
                      ),
                    ],
                  );
                }),
              ),
              verticalSpace(90),
              ExploreAllButtonSearch(
                text: 'Discover more Recipes',
                onTap: () => viewModel.toAllDishesScreen(recipes),
              ),
            ],
          )
        : recipes.isEmpty
            ? SizedBox(
                height: 500.h,
                child: Center(
                    child: Text(
                  'No Recipe Found',
                  style:
                      globalTextStyle(fontSize: 15.sp, color: kcPrimaryColor),
                )))
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
                                  rating: calculateAverageRating(
                                      recipes[index].comment!),
                                  savedRecipeList: viewModel.savedRecipes,
                                  recipeId: recipes[index].docId!,
                                  onTap: () => viewModel
                                      .toDishDetailsScreen(recipes[index]),
                                  foodImagePath: recipes[index]
                                      .coverImage
                                      .where(
                                          (element) => element.contains('.jpg'))
                                      .first,
                                  dishName: recipes[index].title,
                                  duration: recipes[index].prepTime,
                                  chefImagePath:
                                      recipes[index].user!.displayPicture!,
                                );
                              },
                              childCount: recipes.length,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  verticalSpace(90),
                  ExploreAllButtonSearch(
                    text: 'Discover more Recipes',
                    onTap: () => viewModel.toAllDishesScreen(recipes),
                  )
                ],
              );
  }
}
//
