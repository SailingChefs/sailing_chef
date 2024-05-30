import 'package:flutter/rendering.dart';
import 'package:sailing_chefs/app/extenstions.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';
import 'package:sailing_chefs/ui/views/index/widgets/shimmer_dishes.dart';
import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile.dart';

class DishListIndexScreen extends ViewModelWidget<IndexViewModel> {
  const DishListIndexScreen({super.key});

  @override
  Widget build(BuildContext context, IndexViewModel viewModel) {
    final List<RecipeModel> dishes = viewModel.dishes;

    return viewModel.showShimmer
        ? const ShimmerDishes()
        : viewModel.dishes.isEmpty
            ? SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Center(
                  child: Text(
                    'No Dishes Found',
                    style:
                        globalTextStyle(fontSize: 14.sp, color: kcPrimaryColor,letterSpacing: -0.5),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  dishes.sort((a, b) => b.createdTime.compareTo(a.createdTime));

                  return ShrinkWrappingViewport(
                    offset: ViewportOffset.zero(),
                    axisDirection: AxisDirection.down,
                    slivers: [
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 7.5 / 9,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return PrimaryGridTile(
                              chefId: dishes[index].user == null
                                  ? ''
                                  : dishes[index].user!.uid!,
                              rating: dishes[index].rating,
                              recipe: dishes[index],
                              onTap: () =>
                                  viewModel.toDishDetailsScreen(dishes[index]),
                              foodImagePath: dishes[index]
                                  .coverImage
                                  .where((element) => element.isFirebaseImageUrl)
                                  .first,
                              dishName: dishes[index].title,
                              duration: dishes[index].prepTime,
                              chefImagePath: dishes[index].user == null
                                  ? ''
                                  : dishes[index].user!.displayPicture == null
                                      ? ''
                                      : dishes[index].user!.displayPicture!,
                            );
                          },
                          childCount: dishes.length >= 10 ? 10 : dishes.length,
                        ),
                      ),
                    ],
                  );
                }),
              );
  }
}
