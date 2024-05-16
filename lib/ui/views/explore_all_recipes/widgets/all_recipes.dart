import 'package:sailing_chefs/core/helpers/avergae_calculator.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/explore_all_recipes/explore_all_recipes_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class AllRecipesScreen extends ViewModelWidget<ExploreAllRecipesViewModel> {
  final List<RecipeModel> recipes;
  const AllRecipesScreen({super.key, required this.recipes});

  @override
  Widget build(BuildContext context, ExploreAllRecipesViewModel viewModel) {
    return recipes.isEmpty
        ? const Center(child: Text('No Recipe Found'))
        : SizedBox(
            height: screenHeight(context) * 0.77,
            child: GridView.builder(
              itemCount: recipes.length,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 18.0,
                childAspectRatio: 7.4 / 9,
              ),
             

            itemBuilder: (BuildContext context, int index) {
              return PrimaryGridTile(
                chefId: recipes[index].user!.uid!,
                  rating: calculateAverageRating(recipes[index].comment!),
                  savedRecipeList: viewModel.savedRecipes,
                  recipeId: recipes[index].docId!,
                  onTap: () => viewModel
                      .toDishDetailsScreen(recipes[index]),
                  foodImagePath: recipes[index].coverImage
                      .where((element) => element.contains('.jpg'))
                      .first,
                  dishName: recipes[index].title,
                  duration: recipes[index].prepTime,
                  chefImagePath:
                     recipes[index].user!.displayPicture!);
            },
          ),
        );

  }
}