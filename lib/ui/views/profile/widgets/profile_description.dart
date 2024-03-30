import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

import '../../../../core/helpers/capitalize_first_fucntion.dart';

class ProfileDescriptionProfileScreen extends StatelessWidget {
  const ProfileDescriptionProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userDetails!.location == '' && userDetails!.syJoy == ''
              ? ' '
              : userDetails!.location == ''
                  ? capitalizeEachWord(userDetails!.syJoy!)
                  : userDetails!.syJoy == ''
                      ? capitalizeEachWord(userDetails!.location!)
                      : capitalizeEachWord(
                          '${userDetails!.syJoy!}, ${userDetails!.location!}'),
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
