import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/profile/profile_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/grid_view.dart';

class SavedProfileScreen extends ViewModelWidget<ProfileViewModel> {
  const SavedProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return Expanded(
      flex: 1,
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
          return  PrimaryGridViewCard(
            onTap: (){},
          //  viewModel.toDishDetailsScreen,
              foodImagePath: 'https://th.bing.com/th/id/OIG3.5u5ZBGkvLQn1ELp4UqXH',
              dishName: "dish name",
              duration: "30",
              chefImagePath: 'https://images.app.goo.gl/4iwFcv1jzruDgVuJA');
        },
      ),
    );
  }
}
