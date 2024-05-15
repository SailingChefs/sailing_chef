import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/saved_recipes_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

import '../../../../core/helpers/avergae_calculator.dart';

class FollowingSavedRecipesScreen
    extends ViewModelWidget<SavedRecipesViewModel> {
  const FollowingSavedRecipesScreen({super.key});

  @override
  Widget build(BuildContext context, SavedRecipesViewModel viewModel) {
    return viewModel.followingRecipes!.isEmpty
        ? const Center(child: Text('No Following Saved Recipe Found'))
        : SizedBox(
            height: 500.h,
            child: GridView.builder(
              itemCount: viewModel.followingRecipes!.length,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.h),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 18.0,
                childAspectRatio: 7.4 / 9,
              ),
              itemBuilder: (BuildContext context, int index) {
                return PrimaryGridTile(
                  rating: calculateAverageRating(viewModel.followingRecipes![index].comment!) ,
                    savedRecipeList: viewModel.savedRecipes,
                    recipeId: viewModel.followingRecipes![index].docId!,
                    onTap: () => viewModel.toDishDetailsScreen(
                        viewModel.followingRecipes![index]),
                    foodImagePath:
                        viewModel.followingRecipes![index].coverImage.first,
                    dishName: viewModel.followingRecipes![index].title,
                    duration: viewModel.followingRecipes![index].prepTime,
                    chefImagePath: viewModel
                        .followingRecipes![index].user!.displayPicture!);
              },
            ),
          );
  }
}
