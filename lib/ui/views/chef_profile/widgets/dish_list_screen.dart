import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/grid_view.dart';

class DishListScreen extends ViewModelWidget<ChefProfileViewModel> {
  final UserModel user;
  const DishListScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context, ChefProfileViewModel viewModel) {
    const double itemHeight = 7.4 / 9 * 140;
    final int itemCount = viewModel.chefRecipes!.length;
    double totalHeight = itemHeight * itemCount;
    final List<RecipeModel> recipes = viewModel.chefRecipes!;
    return viewModel.chefRecipes!.isEmpty
        ? const Center(child: Text('No Recipe Found'))
        : SizedBox(
            height: totalHeight.h,
            child: GridView.builder(
              itemCount: recipes.length,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.h),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 18.0,
                childAspectRatio: 7.4 / 9,
              ),
              itemBuilder: (BuildContext context, int index) {
                return PrimaryGridViewCard(
                  onTap: () => viewModel.toDishDetailsScreen(index),
                  foodImagePath: recipes[index].coverImage.first,
                  dishName: recipes[index].title,
                  duration: recipes[index].prepTime,
                  chefImagePath: user.displayPicture!,
                );
              },
            ),
          );
  }
}
