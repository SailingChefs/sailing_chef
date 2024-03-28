import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sailing_chefs/ui/widgets/grid_view.dart';

class FollowingSavedRecipesScreen extends StatelessWidget {
  const FollowingSavedRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.h,
      child: GridView.builder(
        itemCount: 10,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.h),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 18.0,
          childAspectRatio: 7.4 / 9,
        ),
        itemBuilder: (BuildContext context, int index) {
          return const PrimaryGridViewCard(
              foodImagePath: 'assets/images/background/onboarding2.png',
              dishName: "dish name",
              duration: "30",
              chefImagePath: 'assets/images/icons/chef.jpg');
        },
      ),
    );
  }
}
