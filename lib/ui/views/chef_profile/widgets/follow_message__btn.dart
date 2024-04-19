import 'package:sailing_chefs/core/imports/core_imports.dart';
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
      width: 420,
      height: 70,
      child: Row(
        children: [
          FollowBtuton(
            onPressed: () {},
            buttonText: 'Follow',
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          horizontalSpaceTiny,
          MessageBtuton(
            onPressed: () {
              viewModel.moveToChatScreen(user);
            },
            buttonText: 'Message',
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
