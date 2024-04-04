import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_viewmodel.dart';

import '../../../../core/helpers/capitalize_first_fucntion.dart';

class ChefProfileDetailsDesc extends ViewModelWidget<ChefProfileViewModel> {
  const ChefProfileDetailsDesc( {required this.user,super.key});
   final UserModel user;
  @override
  Widget build(BuildContext context, ChefProfileViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
          "${capitalizeEachWord(user.syJoy!)}, ${viewModel.placemarks!.first.country!}",
            style: globalTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: kcBlackColor,
            ),
          ),
          verticalSpaceSmall,
          Text(
            user.bio!,
            style: globalTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: kcBlackColor,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          verticalSpaceTiny,
          Row(
            children: [
              const Icon(
                Icons.link_outlined,
                color: kcPrimaryColor,
                size: 20,
              ),
              horizontalSpaceSmall,
              Text(
                user.link!,
                style: globalTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: kcPrimaryColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
