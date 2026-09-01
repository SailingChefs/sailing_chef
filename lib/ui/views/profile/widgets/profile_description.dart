// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use

import 'package:flutter_svg/svg.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/profile/profile_viewmodel.dart';

import '../../../../core/helpers/capitalize_first_fucntion.dart';

class ProfileDescriptionProfileScreen
    extends ViewModelWidget<ProfileViewModel> {
  const ProfileDescriptionProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpaceSmall,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                userDetails!.displayName!.isEmpty
                    ? ''
                    : capitalizeEachWord(userDetails!.displayName!),
                style: globalTextStyle(
                    letterSpacing: -0.3,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: kcBlackColor),
              ),
              if (userDetails!.userRole == 'chef' &&
                  (userDetails!.isAvailable ?? false)) ...[
                SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF34A853),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Available',
                    style: globalTextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ],
          ),
          userDetails!.userRole == 'guest'
              ? Container()
              : userDetails!.namedLocation == null &&
                      userDetails!.boatName == null
                  ? Container()
                  : Text(
                      userDetails!.namedLocation == null
                          ? userDetails!.boatName!
                          : userDetails!.boatName == null
                              ? userDetails!.namedLocation!
                              : userDetails!.namedLocation != null &&
                                      userDetails!.boatName!.isNotEmpty
                                  ? '${userDetails!.boatName!},${userDetails!.namedLocation!}'
                                  : userDetails!.namedLocation!,
                      style: globalTextStyle(
                        fontSize: 14.sp,
                        letterSpacing: -0.3,
                        fontWeight: FontWeight.w600,
                        color: kcBlackColor,
                      ),
                    ),
          verticalSpaceSmall,
          Text(
            userDetails!.bio!.isEmpty ? '' : userDetails!.bio!,
            style: globalTextStyle(
              fontSize: 14.sp,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w400,
              height: 1.2,
              color: kcBlackColor,
            ),
          ),
          verticalSpace(8),
          userDetails!.userRole == 'guest'
              ? Container()
              : userDetails!.link!.isEmpty
                  ? Container()
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
                            viewModel.onClickUrl(userDetails!.link!);
                          },
                          child: SizedBox(
                            width: 300,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              userDetails!.link!.isEmpty
                                  ? ' '
                                  : userDetails!.link!,
                              style: globalTextStyle(
                                fontSize: 14.sp,
                                letterSpacing: -0.3,
                                fontWeight: FontWeight.w400,
                                color: kcPrimaryColorDark,
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
