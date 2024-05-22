import 'package:flutter/rendering.dart';
import 'package:sailing_chefs/core/helpers/avergae_calculator.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class DishListScreen extends ViewModelWidget<ChefProfileViewModel> {
  final UserModel user;
  const DishListScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context, ChefProfileViewModel viewModel) {
    final List<RecipeModel> recipes = viewModel.chefRecipes!;
    return recipes.isNotEmpty
        ? user.userRole != 'culinarySchool' && user.userRole == 'chef'
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
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
                              chefId: recipes[index].user!.uid!,
                              rating: calculateAverageRating(
                                  recipes[index].comment!),
                              recipe: recipes[index],
                              onTap: () => viewModel.toDishDetailsScreen(index),
                              foodImagePath: recipes[index]
                                  .coverImage
                                  .where((element) => element.contains('.jpg'))
                                  .first,
                              dishName: recipes[index].title,
                              duration: recipes[index].prepTime,
                              chefImagePath: user.displayPicture == null
                                  ? ''
                                  : user.displayPicture!,
                            );
                          },
                          childCount: recipes.length,
                        ),
                      ),
                    ],
                  );
                }),
              )
            : Container()
        : SizedBox(
            width: 400,
            height: 300,
            child: Center(
              child: Text(
                'No Dishes Found',
                style: globalTextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: kcBlackColor),
              ),
            ),
          );
  }
}
