import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/search/search_viewmodel.dart';
import 'package:sailing_chefs/ui/views/search/widgets/explore_all_buttons.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class RecipeScreen extends ViewModelWidget<SearchViewModel> {
  final List<RecipeModel> recipes;
  const RecipeScreen({required this.recipes, super.key});

  @override
  Widget build(BuildContext context, SearchViewModel viewModel) {
    return viewModel.searchControllerRecipe.text.isNotEmpty
        ? Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: viewModel.searchRecipes(recipes).length,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 18.0,
                    childAspectRatio: 7.4 / 9,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final recipe = viewModel.searchRecipes(recipes).elementAt(index);
                    return PrimaryGridTile(
                        rating: recipe.rating,
                        chefId: recipe.user!.uid!,
                        recipe: recipe,
                        onTap: () => viewModel.toDishDetailsScreen(recipe),
                        foodImagePath:
                            recipe.coverImage.where((element) => element.isFirebaseImageUrl).first,
                        dishName: recipe.title,
                        duration: recipe.prepTime,
                        chefImagePath: recipe.user!.displayPicture!);
                  },
                ),
              ),
              verticalSpace(90),
              ExploreAllButtonSearch(
                text: 'Discover more Recipes',
                onTap: () => viewModel.toAllDishesScreen(recipes),
              ),
            ],
          )
        : recipes.isEmpty
            ? SizedBox(
                height: 500.h,
                child: Center(
                    child: Text(
                  'No Recipe Found',
                  style: globalTextStyle(fontSize: 15.sp, color: kcPrimaryColor),
                )))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    GridView.builder(
                      itemCount: recipes.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 18.0,
                        childAspectRatio: 7.4 / 9,
                      ),
                      itemBuilder: (BuildContext context, int index) {
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
                            chefImagePath: recipes[index].user?.displayPicture ?? '');
                      },
                    ),
                    verticalSpace(10),
                    ExploreAllButtonSearch(
                      text: 'View All Recipes',
                      onTap: () => viewModel.toAllDishesScreen(recipes),
                    ),
                    verticalSpace(30),
                  ],
                ),
              );
  }
}
//
