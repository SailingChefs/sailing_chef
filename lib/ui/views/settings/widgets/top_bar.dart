import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/settings/settings_viewmodel.dart';

class TopBarSettingsScreen extends ViewModelWidget<SettingsViewModel> {
  const TopBarSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, SettingsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => viewModel.getBack,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 8.0.dg),
              height: 36.h,
              width: 36.w,
              decoration: const BoxDecoration(
                color: kcVeryLightGrey,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios,
                color: kcBlackColor,
                size: 20.sp,
              ),
            ),
          ),
          Text(
            'Settings',
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
}
