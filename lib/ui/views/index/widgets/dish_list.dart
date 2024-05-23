
import 'package:flutter/rendering.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';
import 'package:sailing_chefs/ui/views/index/widgets/shimmer_dishes.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class DishListIndexScreen extends ViewModelWidget<IndexViewModel> {
  const DishListIndexScreen({super.key});

  @override
  Widget build(BuildContext context, IndexViewModel viewModel) {
    return StreamBuilder<List<RecipeModel>>(
      stream: viewModel.recipeService.fetchRecipesAsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return const ShimmerDishes();
        }

        List<RecipeModel> recipes = snapshot.data!;

        return Padding(
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
                      childAspectRatio: 6.7 / 9,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return PrimaryGridTile(
                          chefId: recipes[index].uid,
                          rating: recipes[index].rating,
                          recipe: recipes[index],
                          onTap: () => viewModel.toDishDetailsScreen(recipes[index]),
                          foodImagePath: recipes[index]
                              .coverImage
                              .where((element) => element.contains('.jpg'))
                              .first,
                          dishName: recipes[index].title,
                          duration: recipes[index].prepTime,
                          chefImagePath: recipes[index].user != null
                              ? recipes[index].user!.displayPicture ?? ''
                              : '',
                        );
                      },
                      childCount: recipes.length,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
