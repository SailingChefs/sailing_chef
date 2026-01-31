import 'package:flutter/rendering.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/saved_recipes_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/widgets/explore_all_button.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/widgets/search_bar.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class AllSavedRecipesScreen extends ViewModelWidget<SavedRecipesViewModel> {
  const AllSavedRecipesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, SavedRecipesViewModel viewModel) {
    return Column(children: [
      const SearchBarSavedRecipesScreen(),
      verticalSpaceMedium,
      if (viewModel.searchSavedController.text.isNotEmpty)
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return ShrinkWrappingViewport(
                  offset: ViewportOffset.zero(),
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
                          final recipe =
                              viewModel.searchRecipes().elementAt(index);
                          return PrimaryGridTile(
                              chefId: savedRecipesGlobal[index].user!.uid!,
                              rating: savedRecipesGlobal[index].rating,
                              recipe: recipe,
                              onTap: () =>
                                  viewModel.toDishDetailsScreen(recipe),
                              foodImagePath: recipe.coverImage
                                  .where((element) => element.contains('.jpg'))
                                  .first,
                              dishName: recipe.title,
                              duration: recipe.prepTime,
                              chefImagePath: recipe.user!.displayPicture!);
                        },
                        childCount: viewModel.searchRecipes().length,
                      ),
                    ),
                  ],
                );
              }),
            ),
            verticalSpace(90),
            const ExploreAllButton(),
          ],
        )
      else
        savedRecipesGlobal.isEmpty
            ? const Center(child: Text('No saved recipes found'))
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return ShrinkWrappingViewport(
                        offset: ViewportOffset.zero(),
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
                                    chefId:
                                        savedRecipesGlobal[index].user!.uid!,
                                    rating: savedRecipesGlobal[index].rating,
                                    recipe: savedRecipesGlobal[index],
                                    onTap: () => viewModel.toDishDetailsScreen(
                                        savedRecipesGlobal[index]),
                                    foodImagePath: savedRecipesGlobal[index]
                                        .coverImage
                                        .where((element) =>
                                            element.contains('.jpg'))
                                        .first,
                                    dishName: savedRecipesGlobal[index].title,
                                    duration:
                                        savedRecipesGlobal[index].prepTime,
                                    chefImagePath: savedRecipesGlobal[index]
                                        .user!
                                        .displayPicture!);
                              },
                              childCount: savedRecipesGlobal.length,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  verticalSpace(90),
                  const ExploreAllButton(),
                ],
              )
    ]);
  }
}
//
