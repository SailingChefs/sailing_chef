import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/explore_all_recipes/explore_all_recipes_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class SearchViewAllRecipes extends ViewModelWidget<ExploreAllRecipesViewModel> {
  const SearchViewAllRecipes({super.key});

  @override
  Widget build(BuildContext context, ExploreAllRecipesViewModel viewModel) {
   return viewModel.searchRecipes().isEmpty
        ? SizedBox(
            height: 500.h,  
          child: const Center(child: Text('No Recipe Found')))
        : SizedBox(
            height: 500.h,
            child: GridView.builder(
              itemCount: viewModel.searchRecipes().length,
              padding: EdgeInsets.symmetric( vertical: 15.h),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 18.0,
                childAspectRatio: 7.4 / 9,
              ),
              itemBuilder: (BuildContext context, int index) {
                final RecipeModel recipe = viewModel.searchRecipes().elementAt(index);
               return PrimaryGridTile(
                      savedRecipeList: viewModel.savedRecipes,
                      recipeId: recipe.docId,
                      onTap: () => viewModel.toDishDetailsScreen(recipe),
                      foodImagePath: recipe.coverImage
                          .where((element) => element.contains('.jpg'))
                          .first,
                      dishName: recipe.title,
                      duration: recipe.prepTime,
                      chefImagePath: recipe.user!.displayPicture!);
              },
            ),
          );
  }
}
// 