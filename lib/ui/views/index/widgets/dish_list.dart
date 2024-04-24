import 'package:flutter/rendering.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class DishListIndexScreen extends ViewModelWidget<IndexViewModel> {
  const DishListIndexScreen({super.key});

  @override
  Widget build(BuildContext context, IndexViewModel viewModel) {
    final List<RecipeModel> dishes = viewModel.dishes!;

    return viewModel.dishes!.isEmpty
        ? Text(
            'No Dish Found',
            style: Theme.of(context).textTheme.titleMedium,
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
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
                          savedRecipeList: viewModel.savedRecipes!,
                          recipeId: dishes[index].docId,
                          onTap: () => viewModel.toDishDetailsScreen(index),
                          foodImagePath: dishes[index].coverImage.first,
                          dishName: dishes[index].title,
                          duration: dishes[index].prepTime,
                          chefImagePath: dishes[index].user!.displayPicture!,
                        );
                      },
                      childCount: dishes.length,
                    ),
                  ),
                ],
              );
            }),
          );
  }
}
