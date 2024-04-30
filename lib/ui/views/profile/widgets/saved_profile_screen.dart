import 'package:flutter/rendering.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/profile/profile_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class SavedProfileScreen extends ViewModelWidget<ProfileViewModel> {
  const SavedProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    final savedRecipes = viewModel.savedRecipes;
    return savedRecipes.isEmpty
        ? const Center(child: Text('No saved recipes'))
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
                          recipeId: savedRecipes[index].recipeId,
                          onTap: () => viewModel.toDishDetailsScreen(index),
                          foodImagePath:
                              savedRecipes[index].recipeModel!.coverImage.first,
                          dishName: savedRecipes[index].recipeModel!.title,
                          duration: savedRecipes[index].recipeModel!.prepTime,
                          chefImagePath: savedRecipes[index]
                              .recipeModel!
                              .user!
                              .displayPicture!,
                        );
                      },
                      childCount: savedRecipes.length,
                    ),
                  ),
                ],
              );
            }),
          );
  }
}
