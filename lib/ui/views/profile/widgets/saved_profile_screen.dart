import 'package:flutter/rendering.dart';
import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/profile/profile_viewmodel.dart';
import 'package:sailing_chefs/ui/views/profile/widgets/listview.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class SavedProfileScreen extends ViewModelWidget<ProfileViewModel> {
  const SavedProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return userDetails!.userRole == 'culinarySchool'
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (viewModel.isBusy) const CircularProgressIndicator() else userDetails!.schoolCourses!.isNotEmpty
                        ? ListViewSavedCources(
                            courses: viewModel.courses,
                          )
                        : SizedBox(
                            height: screenHeight(context) * 0.31,
                            width: screenWidth(context) * 0.98,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Allow chefs to book your courses',
                                  style: globalTextStyle(
                                      fontSize: 14.0.dg,
                                      color: filterIconColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                verticalSpaceMedium,
                                GestureDetector(
                                  onTap: viewModel.callCourseNameBottomSheet,
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
                          ),
              ],
            ),
          )
        : viewModel.savedRecipes.isEmpty
            ? SizedBox(
                height: screenHeight(context) * 0.31,
                child: Center(
                    child: Text(
                  'Save your favorite recipes for later',
                  style: globalTextStyle(
                    fontSize: 14,
                    color: kcPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                )),
              )
            : Padding(
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
                              chefId: viewModel.savedRecipes[index].user!.uid!,
                              rating: viewModel.savedRecipes[index].rating,
                              recipe: viewModel.savedRecipes[index],
                              onTap: () => viewModel.toDishDetailsScreen(
                                  index, viewModel.savedRecipes[index]),
                              foodImagePath: viewModel
                                  .savedRecipes[index].coverImage
                                  .where(
                                      (element) => element.isFirebaseImageUrl)
                                  .first,
                              dishName: viewModel.savedRecipes[index].title,
                              duration: viewModel.savedRecipes[index].prepTime,
                              chefImagePath: viewModel.savedRecipes[index].user!
                                          .displayPicture ==
                                      null
                                  ? ''
                                  : viewModel.savedRecipes[index].user!
                                      .displayPicture!,
                            );
                          },
                          childCount: viewModel.savedRecipes.length,
                        ),
                      ),
                    ],
                  );
                }),
              );
  }
}
