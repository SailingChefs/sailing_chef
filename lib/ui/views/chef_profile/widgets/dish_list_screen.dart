import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/dish_model.dart';
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/grid_view.dart';

class DishListScreen extends ViewModelWidget<ChefProfileViewModel> {
  const DishListScreen({super.key});

  @override
  Widget build(BuildContext context, ChefProfileViewModel viewModel) {
   const double itemHeight =
        7.4 / 9 * 140; 
    final int itemCount = viewModel.dishes.length;
    double totalHeight = itemHeight * itemCount;
    final List<DishModel> dishes = viewModel.dishes;
    return SizedBox(
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
            onTap: viewModel.toDishDetailsScreen,
              foodImagePath: dishes[index].dishImagePath,
              dishName: dishes[index].dishName,
              duration: dishes[index].dishPreparationTime,
              chefImagePath: dishes[index].dishChefImage,
            );
        },
      ),
    );
  }
}
