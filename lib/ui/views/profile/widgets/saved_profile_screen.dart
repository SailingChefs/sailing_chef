import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/profile/profile_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class SavedProfileScreen extends ViewModelWidget<ProfileViewModel> {
  const SavedProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    final savedRecipes = viewModel.savedRecipes;
    return Expanded(
      flex: 1,
      child: GridView.builder(
        itemCount: savedRecipes!.length,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.h),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 18.0,
          childAspectRatio: 7.4 / 9,
        ),
        itemBuilder: (BuildContext context, int index) {
          return PrimaryGridTile(
              recipeId: savedRecipes[index].recipeId,
              savedRecipeList: viewModel.savedRecipes,
              onTap: () {},
              //  viewModel.toDishDetailsScreen,
              foodImagePath: savedRecipes[index].recipeModel!.coverImage.first,
              dishName: savedRecipes[index].recipeModel!.title,
              duration: savedRecipes[index].recipeModel!.prepTime,
              chefImagePath: 'https://picsum.photos/200');
        },
      ),
    );
  }
}
