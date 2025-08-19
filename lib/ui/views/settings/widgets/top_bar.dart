import 'package:flutter_svg/flutter_svg.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/settings/settings_viewmodel.dart';

class TopBarSettingsProfile extends ViewModelWidget<SettingsViewModel>
    implements PreferredSizeWidget {
  const TopBarSettingsProfile({super.key});

  @override
  Widget build(BuildContext context, SettingsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 25.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => viewModel.getBack(),
              child: SvgPicture.asset('assets/images/icons/backbutton.svg')),
          Text(
            'Settings',
            style: globalTextStyle(
              fontSize: 16.0.dg,
              color: kcBlackColor,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w500,
            ),
          ),
          horizontalSpaceSmall,
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
