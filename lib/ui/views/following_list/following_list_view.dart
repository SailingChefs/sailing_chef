// ignore_for_file: sort_child_properties_last

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/following_list/widgets/follower_list.dart';

import 'package:sailing_chefs/ui/views/following_list/widgets/tab_bars.dart';
import 'package:sailing_chefs/ui/views/following_list/widgets/topbar_following.dart';
import 'package:sailing_chefs/ui/views/following_list/widgets/followinglist.dart';
import 'following_list_viewmodel.dart';

class FollowingListView extends StackedView<FollowingListViewModel> {
 final  bool isfromFollowing;
  final UserModel user;

  const FollowingListView({Key? key, required this.user, required this.isfromFollowing}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    FollowingListViewModel viewModel,
    Widget? child,
  ) {
    return viewModel.isBusy
        ? const Center(
          child: CircularProgressIndicator(
              color: kcPrimaryColor,
            ),
        )
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: TopBarFollowing(
              name: user.displayName!,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  verticalSpaceSmall,
                   const TabBarsFollowing(),
                  verticalSpaceTiny,
                  Column(
                    children: [
                      verticalSpaceTiny,
                      viewModel.isFollower ? FollowerList() : FollowingList(),
                    ],
                  )
                ],
              ),
            ),
          );
  }

  @override
  void onViewModelReady(FollowingListViewModel viewModel) {
    viewModel.onViewModelReady(user.uid!);
    super.onViewModelReady(viewModel);
  }

  @override
  FollowingListViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      FollowingListViewModel(isFromFollowing: isfromFollowing);
}
