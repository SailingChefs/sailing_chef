import 'package:flutter/rendering.dart';
import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class DishListScreen extends ViewModelWidget<ChefProfileViewModel> {
  final UserModel user;
  const DishListScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context, ChefProfileViewModel viewModel) {
    final recipes = viewModel.chefRecipes;
    return recipes.isNotEmpty
        ? user.userRole != 'culinarySchool' && user.userRole == 'chef'
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return ShrinkWrappingViewport(
                    offset: ViewportOffset.zero(),
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
                              rating: recipes[index].rating,
                              recipe: recipes[index],
                              onTap: () => viewModel.toDishDetailsScreen(index),
                              foodImagePath: recipes[index]
                                  .coverImage
                                  .where(
                                      (element) => element.isFirebaseImageUrl)
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
