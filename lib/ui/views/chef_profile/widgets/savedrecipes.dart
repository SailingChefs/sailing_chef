import 'package:flutter/rendering.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_viewmodel.dart';
import 'package:sailing_chefs/ui/views/chef_profile/widgets/courselist.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class SavedChefProfileScreen extends ViewModelWidget<ChefProfileViewModel> {
  final UserModel user;
  const SavedChefProfileScreen(this.user, {super.key});

  @override
  Widget build(BuildContext context, ChefProfileViewModel viewModel) {
    final savedRecipes = viewModel.savedRecipes;
    return savedRecipes.isEmpty
        ? user.userRole == 'culinarySchool'
            ? Center(
                child: Container(
                  width: screenWidth(context) * 0.9,
                  height: screenHeight(context) * 0.4,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      user.schoolCourses!.isNotEmpty
                          ? const ListViewChefSavedCources()
                          : Text(
                              'No Courses Yet',
                              style: globalTextStyle(
                                  fontSize: 13.0,
                                  color: kcBlackColor,
                                  fontWeight: FontWeight.w500),
                            ),
                    ],
                  ),
                ),
              )
            : const Center(child: Text('No saved recipes'))
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
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
                          savedRecipeList: viewModel.savedRecipes,
                          recipeId: savedRecipes[index].recipeId,
                          onTap: () => viewModel.toDishDetailsScreen(index),
                          foodImagePath: savedRecipes[index]
                              .recipeModel!
                              .coverImage
                              .where((element) => element.contains('.jpg'))
                              .first,
                          dishName: savedRecipes[index].recipeModel!.title,
                          duration: savedRecipes[index].recipeModel!.prepTime,
                          chefImagePath: savedRecipes[index]
                              .recipeModel!
                              .user!
                              .displayPicture!,
                        );
                      },
                      childCount: savedRecipes.length,
                    ),
                  ),
                ],
              );
            }),
          );
  }
}
