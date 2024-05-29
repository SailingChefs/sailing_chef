// ignore_for_file: deprecated_member_use

import 'package:flutter_svg/svg.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/profile/widgets/profile_description.dart';
import 'package:sailing_chefs/ui/views/profile/widgets/profile_detals.dart';
import 'package:sailing_chefs/ui/views/profile/widgets/saved_guest_button.dart';
import 'package:sailing_chefs/ui/views/profile/widgets/saved_profile_screen.dart';
import 'package:sailing_chefs/ui/views/profile/widgets/shimmer.dart';
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
      child: Scaffold(
        backgroundColor: kcBackgroundColor,
        appBar: const TopBarProfileScreen(),
        body: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 30),
          child: SingleChildScrollView(
            controller: viewModel.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileDetailsProfileScreen(),
                const ProfileDescriptionProfileScreen(),
                verticalSpace(MediaQuery.of(context).size.height * 0.04),
                userDetails!.userRole == 'guest'
                    ? Container()
                    : FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TabBarProfileScreen(),
                            IconButton(
                              onPressed: viewModel.toFilterView,
                              icon: SvgPicture.asset(
                                'assets/images/misc/equilizer.svg',
                                color: filterIconColor,
                                width: 30.dg,
                                height: 30.dg,
                              ),
                            ),
                          ],
                        ),
                      ),
                userDetails!.userRole == 'guest'
                    ? Column(
                        children: [
                          const SavedGuestButton(),
                          verticalSpaceMedium,
                          viewModel.isBusy
                              ? const ShimmerLoaderChefView()
                              : const SavedProfileScreen(),
                        ],
                      )
                    : viewModel.isBusy
                        ? const ShimmerLoaderChefView()
                        : Column(
                            children: [
                              viewModel.myRecipes.isEmpty
                                  ? const SizedBox()
                                  : verticalSpaceMedium,
                              viewModel.isMySelected
                                  ? const MyRecipesProfileScreen()
                                  : const SavedProfileScreen(),
                            ],
                          ),
              ],
            ),
          ),
        ),
      ),
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
