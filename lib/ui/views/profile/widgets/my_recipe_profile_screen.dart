import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/profile/profile_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class MyRecipesProfileScreen extends ViewModelWidget<ProfileViewModel> {
  const MyRecipesProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return viewModel.myRecipes!.isEmpty
        ? const Center(child: Text('No recipes yet'))
        : Expanded(
            flex: 1,
            child: GridView.builder(
              itemCount: viewModel.myRecipes!.length,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.h),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 18.0,
                childAspectRatio: 7.4 / 9,
              ),
              itemBuilder: (BuildContext context, int index) {
                final RecipeModel recipe = viewModel.myRecipes![index];
                return PrimaryGridTile(
                    recipeId: recipe.docId,
                    savedRecipeList: viewModel.savedRecipes,
                    onTap: () => viewModel.toDishDetailsScreen(index),
                    foodImagePath: recipe.coverImage.any((element) => element != null) ? recipe.coverImage.first : 'https://images.app.goo.gl/SPd1LsjeVohN57Fh8',
                    dishName: recipe.title,
                    duration: recipe.prepTime,
                    chefImagePath: userDetails!.displayPicture!);
              },
            ),
          );
  }
}
