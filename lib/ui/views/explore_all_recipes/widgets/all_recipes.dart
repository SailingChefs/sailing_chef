import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/explore_all_recipes/explore_all_recipes_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class AllRecipesScreen extends ViewModelWidget<ExploreAllRecipesViewModel> {
  const AllRecipesScreen({super.key});

  @override
  Widget build(BuildContext context, ExploreAllRecipesViewModel viewModel) {
    return viewModel.recipes.isEmpty
        ? const Center(child: Text('No Recipe Found'))
        : SizedBox(
            height: ScreenUtil().screenHeight * 0.76,
            child: GridView.builder(
              itemCount: viewModel.recipes.length,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 18.0,
                childAspectRatio: 7.4 / 9,
              ),
              itemBuilder: (BuildContext context, int index) {
                return PrimaryGridTile(
                    savedRecipeList: viewModel.savedRecipes,
                    recipeId: viewModel.recipes[index].docId!,
                    onTap: () =>
                        viewModel.toDishDetailsScreen(viewModel.recipes[index]),
                    foodImagePath: viewModel.recipes[index].coverImage
                        .where((element) => element.contains('.jpg'))
                        .first,
                    dishName: viewModel.recipes[index].title,
                    duration: viewModel.recipes[index].prepTime,
                    chefImagePath:
                        viewModel.recipes[index].user!.displayPicture!);
              },
            ),
          );
  }
}
