import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/grid_view.dart';

class DishListIndexScreen extends ViewModelWidget<IndexViewModel> {
  const DishListIndexScreen({super.key});

  @override
  Widget build(BuildContext context, IndexViewModel viewModel) {
   double itemHeight =
        7.4 / 9 * 140.h; 
    final int itemCount = viewModel.dishes!.length;
    double totalHeight = itemHeight * itemCount;
    final List<RecipeModel> dishes = viewModel.dishes!;

    return viewModel.dishes!.isEmpty ? Text(
          'No Dish Found',
          style: Theme.of(context).textTheme.titleMedium,
    ) :
    SizedBox(
      height: totalHeight.h,
      child: GridView.builder(
        itemCount: dishes.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.h),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 18.0,
          childAspectRatio: 7.4 / 9,
        ),
        itemBuilder: (BuildContext context, int index) {
          return PrimaryGridViewCard(
              onTap: () => viewModel.toDishDetailsScreen(index),
              foodImagePath: dishes[index].coverImage.first,
              dishName: dishes[index].title,
              duration: dishes[index].prepTime,
              chefImagePath: dishes[index].user!.displayPicture!
            );
        },
      ),
    );
  }
}