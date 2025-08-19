import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/theme/text_styles.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:sailing_chefs/ui/views/cullinary_savedrecipes/cullinary_savedrecipes_viewmodel.dart';
import 'package:sailing_chefs/ui/views/cullinary_savedrecipes/widgets/top_bar.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';
import 'package:stacked/stacked.dart';

class CullinarySavedrecipesView
    extends StackedView<CullinarySavedrecipesViewModel> {
  const CullinarySavedrecipesView({super.key});

  @override
  Widget builder(
    BuildContext context,
    CullinarySavedrecipesViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
          appBar: const TopBarSavedRecipesProfile(),
          body: viewModel.savedRecipes.isEmpty
              ? SizedBox(
                  height: screenHeight(context) * 0.9,
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
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 20, bottom: 10),
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
                                chefId:
                                    viewModel.savedRecipes[index].user!.uid!,
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
                                duration:
                                    viewModel.savedRecipes[index].prepTime,
                                chefImagePath: viewModel.savedRecipes[index]
                                            .user!.displayPicture ==
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
                )),
    );
  }

  @override
  CullinarySavedrecipesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CullinarySavedrecipesViewModel();
}
