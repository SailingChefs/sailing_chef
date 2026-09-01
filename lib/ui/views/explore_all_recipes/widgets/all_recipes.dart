import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/explore_all_recipes/explore_all_recipes_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';
import 'package:sailing_chefs/ui/widgets/empty_state.dart';

class AllRecipesScreen extends ViewModelWidget<ExploreAllRecipesViewModel> {
  final List<RecipeModel> recipes;
  const AllRecipesScreen({super.key, required this.recipes});

  @override
  Widget build(BuildContext context, ExploreAllRecipesViewModel viewModel) {
    recipes.sort((a, b) => b.createdTime.compareTo(a.createdTime));
    return recipes.isEmpty
        ? const SizedBox(
            height: 300,
            child: AppEmptyState(
              icon: Icons.restaurant_menu_outlined,
              title: 'No recipes found',
              subtitle: 'Try adjusting your search or filters.',
            ),
          )
        : SizedBox(
            height: screenHeight(context) * 0.77,
            child: GridView.builder(
              shrinkWrap: true,
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
                    rating: recipes[index].rating,
                    recipe: recipes[index],
                    onTap: () => viewModel.toDishDetailsScreen(recipes[index]),
                    foodImagePath: recipes[index]
                        .coverImage
                        .where((element) => element.isFirebaseImageUrl)
                        .first,
                    dishName: recipes[index].title,
                    duration: recipes[index].prepTime,
                    chefImagePath: recipes[index].user!.displayPicture != null
                        ? recipes[index].user!.displayPicture!
                        : '');
              },
            ),
          );
  }
}
