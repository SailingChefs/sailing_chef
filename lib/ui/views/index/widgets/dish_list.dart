import 'package:flutter/rendering.dart';
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

    return viewModel.isBusy ?
      const ShimmerDishes():
      viewModel.dishes.isEmpty
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Center(
              child: Text(
                'No Dishes Found',
                style: globalTextStyle(fontSize: 18.sp, color: kcPrimaryColor),
              ),
            ),
        )
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

                          chefId: dishes[index].user == null ? '' : dishes[index].user!.uid!,
                          rating: dishes[index].rating,

                          
                          onTap: () => viewModel.toDishDetailsScreen(index),
                          foodImagePath: dishes[index]
                              .coverImage
                              .where((element) => element.contains('.jpg'))
                              .first,
                          dishName: dishes[index].title,
                          duration: dishes[index].prepTime,
                          chefImagePath:dishes[index].user == null ? '' :
                              dishes[index].user!.displayPicture == null

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