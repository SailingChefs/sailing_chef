import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/chef_profile/widgets/follow_btn.dart';
import 'package:sailing_chefs/ui/views/chef_profile/widgets/message_btn.dart';

import '../chef_profile_viewmodel.dart';

// ignore: camel_case_types
class Follow_Message_Btns extends ViewModelWidget<ChefProfileViewModel> {
  const Follow_Message_Btns({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context, ChefProfileViewModel viewModel) {
    return SizedBox(
      width: double.maxFinite,
      height: 70.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          // viewModel.followers.contains(firebaseAuth.currentUser!.uid)
          viewModel.isFollowing
              ? FollowBtuton(
                  onPressed: () {
                    // viewModel.onFollow(user);
                    viewModel.addRemoveFollower('following', user);
                  },
                  buttonText: 'Following',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                )
              : FollowBtuton(
                  onPressed: () {
                    viewModel.addRemoveFollower('follower', user);

                    // => viewModel.onFollow(user)
                  },
                  buttonText: 'Follow',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
          // horizontalSpaceTiny,
          MessageBtuton(
            onPressed: ()async  {
             await viewModel.moveToChatScreen(user);
            },
            buttonText: 'Message',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
