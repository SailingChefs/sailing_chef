import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/profile/profile_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class MyRecipesProfileScreen extends ViewModelWidget<ProfileViewModel> {
  const MyRecipesProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return FutureBuilder(
        future: viewModel.myRecipesList(),
        builder: (context, asyncSnapshot) {
          final myRecipes = asyncSnapshot.data;

          return (myRecipes?.isEmpty ?? true)
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.29,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        verticalSpaceLarge,
                        Text(
                          'Create your first recipe today',
                          style: globalTextStyle(
                              color: kcPrimaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        verticalSpaceTiny,
                        SvgPicture.asset(
                          'assets/images/icons/arrow.svg',
                          height: 150.h,
                          // ignore: deprecated_member_use
                          color: kcPrimaryColor,
                        )
                      ],
                    ),
                  ))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    myRecipes!
                        .sort((a, b) => b.createdTime.compareTo(a.createdTime));
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
                              final recipe = myRecipes[index];

                              return PrimaryGridTile(
                                chefId: userDetails!.uid!,
                                rating: recipe.rating,
                                recipe: recipe,
                                onTap: () => viewModel.toDishDetailsScreen(
                                    index, recipe),
                                foodImagePath: recipe.coverImage
                                    .where(
                                        (element) => element.isFirebaseImageUrl)
                                    .first,
                                dishName: recipe.title,
                                duration: recipe.prepTime,
                                chefImagePath:
                                    userDetails!.displayPicture == null
                                        ? ''
                                        : userDetails!.displayPicture!,
                              );
                            },
                            childCount: myRecipes.length,
                          ),
                        ),
                      ],
                    );
                  }),
                );
        });
  }
}
