import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/chef_profile/widgets/chef_details.dart';
import 'package:sailing_chefs/ui/views/chef_profile/widgets/chef_profile_topbar.dart';
import 'package:sailing_chefs/ui/views/chef_profile/widgets/dish_list_screen.dart';
import 'package:sailing_chefs/ui/views/chef_profile/widgets/follow_message__btn.dart';
import 'package:sailing_chefs/ui/views/chef_profile/widgets/recipes.dart';
import 'package:sailing_chefs/ui/views/chef_profile/widgets/savedrecipes.dart';
import 'package:sailing_chefs/ui/views/chef_profile/widgets/shimmer_loader.dart';
import 'package:sailing_chefs/ui/views/chef_profile/widgets/tab_bar.dart';

import 'chef_profile_viewmodel.dart';
import 'widgets/chef_profile_description.dart';

// ignore: must_be_immutable
class ChefProfileView extends StackedView<ChefProfileViewModel> {
  final UserModel user;

  const ChefProfileView({required this.user, super.key});

  @override
  Widget builder(
    BuildContext context,
    ChefProfileViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: ChefProfileTopBar(
            user: user,
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 10.0.w, right: 10.w),

            child: SingleChildScrollView(
              controller: viewModel.scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(30.h),
                  ChefProfileDetailsDesc(
                    user: user,
                  ),
                  ProfileDescriptionChefProfileScreen(user),
                  verticalSpace(10.h),
                  Follow_Message_Btns(user: user),
                  user.userRole == 'chef'
                      ? viewModel.isBusy
                          ? const ShimmerLoaderChefView()
                          : DishListScreen(user: user)
                      : Container(),
                  verticalSpaceTiny,
                  user.userRole == 'guest'
                      ? viewModel.isBusy
                          ? const ShimmerLoaderChefView()
                          : SavedChefProfileScreen(user,
                              savedRecipes: viewModel.userSavedRecipe!)
                      : user.userRole == 'culinarySchool'
                          ? Column(
                              children: [
                                TabBarChefProfileScreen(user),
                                viewModel.isMySelected
                                    ? viewModel.isBusy
                                        ? const ShimmerLoaderChefView()
                                        : const RecipesProfileScreen()
                                    : SavedChefProfileScreen(
                                        user,
                                        savedRecipes: const [],
                                      ),
                              ],
                            )
                          : Container(),
                ],
              ),
            ),
          )),
    );
  }

  @override
  void onViewModelReady(ChefProfileViewModel viewModel) {
    viewModel.onViewModelReady(user);
    super.onViewModelReady(viewModel);
  }

  @override
  ChefProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChefProfileViewModel(userDetails: user);
}
