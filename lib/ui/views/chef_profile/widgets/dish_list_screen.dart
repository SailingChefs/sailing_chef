import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/grid_view.dart';

class DishListScreen extends ViewModelWidget<ChefProfileViewModel> {
  const DishListScreen({super.key});

  @override
  Widget build(BuildContext context, ChefProfileViewModel viewModel) {
    const double itemHeight = 7.4 / 9 * 140;
    const int itemCount = 10;
    const double totalHeight = itemHeight * itemCount;
    return Flexible(
      child: SingleChildScrollView(
        child: SizedBox(
          height: totalHeight.h,
          child: GridView.builder(
            itemCount: 10,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.h),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 18.0,
              childAspectRatio: 7.4 / 9,
            ),
            itemBuilder: (BuildContext context, int index) {
              return const PrimaryGridViewCard(
                  foodImagePath: 'assets/images/background/onboarding.png',
                  dishName: "dish name",
                  duration: "30",
                  chefImagePath: 'assets/images/icons/chef.jpg');
            },
          ),
        ),
      ),
    );
  }
}
