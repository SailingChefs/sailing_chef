import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/chef_profile/widgets/chef_profile_details.dart';
import 'package:sailing_chefs/ui/views/chef_profile/widgets/chef_profile_topbar.dart';
import 'package:sailing_chefs/ui/views/chef_profile/widgets/dish_list_screen.dart';
import 'package:sailing_chefs/ui/views/chef_profile/widgets/follow_message__btn.dart';

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
        body:viewModel.isBusy ? const Center(child: CircularProgressIndicator(
          color: kcBackgroundColor,
        )) : Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const ChefProfileTopBar(),
                verticalSpaceSmall,
                ChefProfileDetails(user: user,),
                verticalSpaceSmall,
                ChefProfileDetailsDesc(user: user,),
                verticalSpaceMedium,
                Follow_Message_Btns(user: user),
                 DishListScreen(user:user),
              ],
            ),
          ),
        ),
      ),
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
      ChefProfileViewModel();
}
