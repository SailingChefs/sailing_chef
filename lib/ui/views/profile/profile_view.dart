import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/profile/widgets/profile_description.dart';
import 'package:sailing_chefs/ui/views/profile/widgets/profile_detals.dart';
import 'package:sailing_chefs/ui/views/profile/widgets/saved_profile_screen.dart';
import 'package:sailing_chefs/ui/views/profile/widgets/tab_bar.dart';
import 'package:sailing_chefs/ui/views/profile/widgets/top_bar.dart';

import 'profile_viewmodel.dart';
import 'widgets/my_recipe_profile_screen.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: viewModel.isBusy
          ? const Center(
              child: CircularProgressIndicator(
              color: kcWhiteColor,
            ))
          : Scaffold(
              backgroundColor: kcBackgroundColor,
              body: Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TopBarProfileScreen(),
                    verticalSpace(35),
                    const ProfileDetailsProfileScreen(),
                    const ProfileDescriptionProfileScreen(),
                    verticalSpaceMedium,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TabBarProfileScreen(),
                        Icon(
                          FlutterRemix.equalizer_line,
                          color: kcPrimaryColor,
                          size: 30.sp,
                        ),
                      ],
                    ),
                    verticalSpaceMedium,
                    viewModel.isMySelected
                        ? const MyRecipesProfileScreen()
                        : const SavedProfileScreen(),
                  ],
                ),
              )),
    );
  }

  @override
  void onViewModelReady(ProfileViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  ProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProfileViewModel();
}
