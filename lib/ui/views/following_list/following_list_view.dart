// ignore_for_file: sort_child_properties_last

import 'package:sailing_chefs/core/imports/core_imports.dart';

import 'package:sailing_chefs/ui/views/following_list/widgets/searchbar_following.dart';
import 'package:sailing_chefs/ui/views/following_list/widgets/tab_bars.dart';
import 'package:sailing_chefs/ui/views/following_list/widgets/topbar_following.dart';
import 'package:sailing_chefs/ui/widgets/followinglist.dart';

import 'following_list_viewmodel.dart';

class FollowingListView extends StackedView<FollowingListViewModel> {
  const FollowingListView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    FollowingListViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      appBar: const TopBarFollowing(),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          verticalSpaceSmall,
          const TabBarsFollowing(),
          verticalSpaceTiny,
          const SearchBarFollwoing(),
          verticalSpaceTiny,
          FollowingFollowerList(),
        ],
      ),
    );
  }

  @override
  FollowingListViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      FollowingListViewModel();
}
