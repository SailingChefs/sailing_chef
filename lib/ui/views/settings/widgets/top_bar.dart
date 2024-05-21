import 'package:flutter_svg/flutter_svg.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/settings/settings_viewmodel.dart';

class TopBarSettingsProfile extends ViewModelWidget<SettingsViewModel> implements PreferredSizeWidget {
  const TopBarSettingsProfile(this.title, {super.key});
  final String title;
  @override
  Widget build(BuildContext context, SettingsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => viewModel.getBack(),
            child: SvgPicture.asset('assets/images/icons/backbutton.svg')
          ),
          Text(
            title,
            style: globalTextStyle(
                fontSize: 20.0.dg,
                color: kcBlackColor,
                fontWeight: FontWeight.w600),
          ),
          horizontalSpaceSmall,
        ],
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
