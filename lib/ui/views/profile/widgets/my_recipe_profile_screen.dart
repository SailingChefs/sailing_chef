import 'package:flutter/rendering.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/profile/profile_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class MyRecipesProfileScreen extends ViewModelWidget<ProfileViewModel> {
  const MyRecipesProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return viewModel.myRecipes!.isEmpty
        ? const Center(child: Text('No recipes yet'))
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
                          savedRecipeList: viewModel.savedRecipes,
                          recipeId: viewModel.myRecipes![index].docId,
                          onTap: () => viewModel.toDishDetailsScreen(
                              index, viewModel.myRecipes![index]),
                          foodImagePath: viewModel.myRecipes![index].coverImage
                              .where((element) => element.contains('.jpg'))
                              .first,
                          dishName: viewModel.myRecipes![index].title,
                          duration: viewModel.myRecipes![index].prepTime,
                          chefImagePath:viewModel.myRecipes![index].user!.displayPicture == null ? '':
                              viewModel.myRecipes![index].user!.displayPicture!,
                        );
                      },
                      childCount: viewModel.myRecipes!.length,
                    ),
                  ),
                ],
              );
            }),
          );
  }
}
