// ignore_for_file: unrelated_type_equality_checks

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
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpaceSmall,
          Text(
            userDetails!.displayName!.isEmpty
                ? ''
                : capitalizeEachWord(userDetails!.displayName!),
            style: globalTextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: kcBlackColor),
          ),
          viewModel.placemarks!.isEmpty
              ? Container()
              : Text(
                  viewModel.placemarks![0].country!.isEmpty &&
                          userDetails!.boatName!.isEmpty
                      ? ' '
                      : viewModel.placemarks![0].country!.isEmpty
                          ? capitalizeEachWord(userDetails!.boatName!)
                          : userDetails!.boatName!.isEmpty
                              ? capitalizeEachWord(
                                  viewModel.placemarks!.first.country!)
                              : capitalizeEachWord(
                                  '${userDetails!.boatName!}, ${viewModel.placemarks!.first.country!}'),
                  style: globalTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kcBlackColor,
                  ),
                ),
          verticalSpaceSmall,
          Text(
            userDetails!.bio!.isEmpty ? '' : userDetails!.bio!,
            style: globalTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: kcBlackColor,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          verticalSpaceTiny,
          userDetails!.link!.isEmpty
              ? Container()
              : Row(
                  children: [
                    const Icon(
                      Icons.link_outlined,
                      color: kcPrimaryColor,
                      size: 20,
                    ),
                    horizontalSpaceSmall,
                    GestureDetector(
                      onTap: () {
                        viewModel.onClickUrl(userDetails!.link!);
                      },
                      child: Text(
                        userDetails!.link!.isEmpty ? ' ' : userDetails!.link!,
                        style: globalTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: kcPrimaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
