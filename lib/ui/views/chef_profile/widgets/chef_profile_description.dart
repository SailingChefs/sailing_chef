import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_viewmodel.dart';

import '../../../../core/helpers/capitalize_first_fucntion.dart';

class ChefProfileDetailsDesc extends ViewModelWidget<ChefProfileViewModel> {
  const ChefProfileDetailsDesc({super.key});

  @override
  Widget build(BuildContext context, ChefProfileViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          capitalizeEachWord('Sy joy, french polynesia'),
          style: globalTextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: kcBlackColor,
          ),
        ),
        verticalSpaceSmall,
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
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
              'www.danicaswebsite.com',
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
