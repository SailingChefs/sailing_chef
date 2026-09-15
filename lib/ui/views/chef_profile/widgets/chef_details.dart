// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use

import 'package:flutter_svg/svg.dart';
import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/common/widgets/available_badge.dart';
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_viewmodel.dart';

class ProfileDescriptionChefProfileScreen extends ViewModelWidget<ChefProfileViewModel> {
  const ProfileDescriptionChefProfileScreen(this.user, {super.key});
  final UserModel user;

  @override
  Widget build(BuildContext context, ChefProfileViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (user.displayName == null || user.displayName!.isEmpty)
            const SizedBox()
          else
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              verticalSpaceSmall,
              Row(
                children: [
                  Flexible(
                    child: Text(
                      capitalizeEachWord(user.displayName!),
                      style: globalTextStyle(
                          letterSpacing: -0.3,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: kcBlackColor),
                    ),
                  ),
                  if (user.userRole == 'chef' && user.isAvailable) ...[
                    horizontalSpaceSmall,
                    const AvailableBadge(),
                  ],
                ],
              ),
            ]),
          if (user.namedLocation == null && user.boatName == null)
            Container()
          else
            Text(
              user.namedLocation == null
                  ? capitalizeEachWord(user.boatName!)
                  : user.boatName!.isEmpty
                      ? capitalizeEachWord(user.namedLocation!)
                      : capitalizeEachWord('${user.boatName!}\n${user.namedLocation}'),
              style: globalTextStyle(
                fontSize: 14.sp,
                letterSpacing: -0.3,
                fontWeight: FontWeight.w600,
                color: kcBlackColor,
              ),
            ),
          if (user.bio == null || user.bio!.isEmpty)
            const SizedBox()
          else
            Column(
              children: [
                verticalSpaceTiny,
                Text(
                  user.bio!,
                  style: globalTextStyle(
                    letterSpacing: -0.3,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: kcBlackColor,
                  ),
                ),
              ],
            ),
          verticalSpaceTiny,
          if (user.link == null || user.link!.isEmpty)
            const SizedBox()
          else
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/icons/link.svg',
                  width: 16,
                  height: 16,
                  color: kcBlackColor.withOpacity(0.6),
                ),
                horizontalSpaceSmall,
                GestureDetector(
                  onTap: () {
                    viewModel.onClickUrl(user.link!);
                  },
                  child: SizedBox(
                    width: 300,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      user.link!.isEmpty ? ' ' : user.link!,
                      style: globalTextStyle(
                        fontSize: 14.sp,
                        letterSpacing: -0.3,
                        fontWeight: FontWeight.w400,
                        color: filterIconColor,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
