import 'package:flutter/rendering.dart';
import 'package:sailing_chefs/core/helpers/avergae_calculator.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class RecipesProfileScreen extends ViewModelWidget<ChefProfileViewModel> {
  const RecipesProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ChefProfileViewModel viewModel) {
    return viewModel.chefRecipes!.isEmpty
        ? SizedBox(
            width: 400,
            height: 325,
            child: Center(
              child: Text('No Recipies Yet',
                  style: globalTextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: kcBlackColor)),
            ))
        : Column(
          children: [
            verticalSpaceSmall,
            Padding(
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
            
                              chefId: viewModel.chefRecipes![index].user!.uid!,
                              rating: calculateAverageRating(viewModel.chefRecipes![index].comment!),
                              recipeId: viewModel.chefRecipes![index].docId!,
                              onTap: () => viewModel.toDishDetailsScreen(index),
                              foodImagePath: viewModel
                                  .chefRecipes![index].coverImage
                                  .where((element) => element.contains('.jpg'))
                                  .first,
                              dishName: viewModel.chefRecipes![index].title,
                              duration: viewModel.chefRecipes![index].prepTime,
                              chefImagePath: viewModel
                                  .chefRecipes![index].user!.displayPicture!,
                            );
                          },
                          childCount: viewModel.chefRecipes!.length,
                        ),
                      ),
                    ],
                  );
                }),
              ),
          ],
        );
  }
}
