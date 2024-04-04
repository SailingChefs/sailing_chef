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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          viewModel.placemarks![0].country!.isEmpty &&
                  userDetails!.syJoy!.isEmpty
              ? ' '
              : viewModel.placemarks![0].country!.isEmpty
                  ? capitalizeEachWord(userDetails!.syJoy!)
                  : userDetails!.syJoy!.isEmpty
                      ? capitalizeEachWord(viewModel.placemarks!.first.country!)
                      : capitalizeEachWord(
                          '${userDetails!.syJoy!}, ${viewModel.placemarks!.first.country!}'),
          style: globalTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: kcBlackColor,
          ),
        ),
        verticalSpaceSmall,
        Text(
          userDetails!.bio == '' ? ' ' : userDetails!.bio!,
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
              userDetails!.link == '' ? ' ' : userDetails!.link!,
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
    );
  }
}
