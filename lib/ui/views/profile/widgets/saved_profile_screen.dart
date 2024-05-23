import 'package:flutter/rendering.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/profile/profile_viewmodel.dart';
import 'package:sailing_chefs/ui/views/profile/widgets/listview.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class SavedProfileScreen extends ViewModelWidget<ProfileViewModel> {
  const SavedProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    final savedRecipes = viewModel.savedRecipes;
    return userDetails!.userRole == 'culinarySchool'
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    viewModel.isBusy ? const CircularProgressIndicator() :
                    viewModel.courses.isNotEmpty
                        ?  ListViewSavedCources(courses: viewModel.courses,)
                        : Column(
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
                  ],
                ),
              )
            :  viewModel.savedRecipes.isEmpty ? const Center(child: Text('No Saved Recipes')) : Padding(
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
                          chefId: savedRecipes[index].user!.uid!,
                          rating: savedRecipes[index].rating,
                          recipe: savedRecipes[index],
                          onTap: () => viewModel.toDishDetailsScreen(
                              index, savedRecipes[index]),
                          foodImagePath: savedRecipes[index]
                             
                              .coverImage
                              .where((element) => element.contains('.jpg'))
                              .first,
                          dishName: savedRecipes[index].title,
                          duration: savedRecipes[index].prepTime,
                          chefImagePath: savedRecipes[index]
                             
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
