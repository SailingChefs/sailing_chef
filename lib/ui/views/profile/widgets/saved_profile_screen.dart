<<<<<<< last
=======


>>>>>>> latest_branch
import 'package:flutter/rendering.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/helpers/avergae_calculator.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/profile/profile_viewmodel.dart';
import 'package:sailing_chefs/ui/views/profile/widgets/listview.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class SavedProfileScreen extends ViewModelWidget<ProfileViewModel> {
  const SavedProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    final savedRecipes = viewModel.savedRecipes;
    return savedRecipes.isEmpty
        ? userDetails!.userRole == 'culinarySchool'
            ? Center(
                child: Container(
                  width: screenWidth(context) * 0.9,
                  height: screenHeight(context) * 0.4,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      userDetails!.schoolCourses!.isNotEmpty
                          ? const ListViewSavedCources()
                          : Column(
                              children: [
                                Text(
                                  'Allow chefs to book your courses',
                                  style: globalTextStyle(
                                      fontSize: 14.0.dg,
                                      color: kcPrimaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                verticalSpaceMedium,
                                GestureDetector(
                                  onTap: () {
                                    viewModel.callCourseNameBottomSheet();
                                  },
                                  child: Container(
                                    width: 165,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: kcPrimaryColor,
                                      borderRadius: BorderRadius.circular(38),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.add_circle,
                                          color: kcwhitecolor,
                                          size: 26,
                                        ),
                                        horizontalSpaceTiny,
                                        Text(
                                          'Add courses',
                                          style: globalTextStyle(
                                              fontSize: 14,
                                              color: kcwhitecolor),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                    ],
                  ),
                ),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Center(
                    child: Text(
                  'Save your favorite recipes for later',
                  style: globalTextStyle(
                      color: kcPrimaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                )))
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
                          chefId: savedRecipes[index].recipeModel!.user!.uid!,
                          rating: calculateAverageRating(
                            savedRecipes[index].recipeModel!.comment!,
                          ),
                          savedRecipeList: viewModel.savedRecipes,
                          recipeId: savedRecipes[index].recipeId,
                          onTap: () => viewModel.toDishDetailsScreen(
                              index, savedRecipes[index].recipeModel!),
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
<<<<<<< last
=======
                          
>>>>>>> latest_branch
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
