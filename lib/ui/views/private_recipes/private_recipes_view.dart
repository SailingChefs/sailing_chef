import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sailing_chefs/core/theme/text_styles.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:sailing_chefs/ui/views/private_recipes/widgets/topbar.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';
import 'package:stacked/stacked.dart';

import 'private_recipes_viewmodel.dart';

class PrivateRecipesView extends StackedView<PrivateRecipesViewModel> {
  const PrivateRecipesView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PrivateRecipesViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
          appBar: const TopBarPrivateRecipes(),
          body: viewModel.isBusy
              ? SizedBox(
                  height: screenHeight(context) * 0.9,
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: kcPrimaryColor,
                  )),
                )
              : viewModel.privateRecipe!.isEmpty
                  ? SizedBox(
                      height: screenHeight(context) * 0.9,
                      child: Center(
                        child: Text(
                          'No Private Recipes Yet!',
                          style: globalTextStyle(
                            fontSize: 14,
                            color: kcPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 20, bottom: 10),
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
                                    chefId: viewModel
                                        .privateRecipe![index].user!.uid!,
                                    rating:
                                        viewModel.privateRecipe![index].rating,
                                    recipe: viewModel.privateRecipe![index],
                                    onTap: () => viewModel.toDishDetailsScreen(
                                        index, viewModel.privateRecipe![index]),
                                    foodImagePath: viewModel
                                        .privateRecipe![index].coverImage
                                        .where((element) =>
                                            element.contains('.jpg'))
                                        .first,
                                    dishName:
                                        viewModel.privateRecipe![index].title,
                                    duration: viewModel
                                        .privateRecipe![index].prepTime,
                                    chefImagePath: viewModel
                                                .privateRecipe![index]
                                                .user!
                                                .displayPicture ==
                                            null
                                        ? ''
                                        : viewModel.privateRecipe![index].user!
                                            .displayPicture!,
                                  );
                                },
                                childCount: viewModel.privateRecipe!.length,
                              ),
                            ),
                          ],
                        );
                      }),
                    )),
    );
  }

  @override
  void onViewModelReady(PrivateRecipesViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  PrivateRecipesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PrivateRecipesViewModel();
}
