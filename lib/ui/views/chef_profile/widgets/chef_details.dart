// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use

import 'package:flutter_svg/svg.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_viewmodel.dart';
import '../../../../core/helpers/capitalize_first_fucntion.dart';

class ProfileDescriptionChefProfileScreen
    extends ViewModelWidget<ChefProfileViewModel> {
  const ProfileDescriptionChefProfileScreen(this.user, {super.key});
  final UserModel user;

  @override
  Widget build(BuildContext context, ChefProfileViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          user.displayName!.isEmpty
              ? const SizedBox()
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  verticalSpaceSmall,
                  Text(
                    capitalizeEachWord(user.displayName!),
                    style: globalTextStyle(
                        letterSpacing: -0.3,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: kcBlackColor),
                  ),
                ]),
          user.namedLocation == null && user.boatName == null
              ? Container()
              : Text(
                  user.namedLocation == null
                      ? capitalizeEachWord(userDetails!.boatName!)
                      : user.boatName!.isEmpty
                          ? capitalizeEachWord(user.namedLocation!)
                          : capitalizeEachWord(
                              '${user.boatName!}, ${user.namedLocation}'),
                  style: globalTextStyle(
                    fontSize: 14.sp,
                    letterSpacing: -0.3,
                    fontWeight: FontWeight.w600,
                    color: kcBlackColor,
                  ),
                ),
          user.bio!.isEmpty
              ? const SizedBox()
              : Column(
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
          user.link!.isEmpty
              ? const SizedBox()
              : Row(
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
                      child: Text(
                        user.link!.isEmpty ? ' ' : user.link!,
                        style: globalTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: filterIconColor,
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
