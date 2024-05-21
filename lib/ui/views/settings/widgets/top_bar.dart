import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/settings/settings_viewmodel.dart';

class TopBarSettingsScreen extends ViewModelWidget<SettingsViewModel> {
  const TopBarSettingsScreen({super.key, required this.title});
  final String title;
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
            onTap: viewModel.getBack,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 8.0.dg),
              height: 26.h,
              width: 26.w,
              decoration: BoxDecoration(
                color: const Color(0xff427536).withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios,
                color: kcBlackColor,
                weight: 0.2.dg,
                size: 16.sp,
              ),
            ),
          ),
          Text(
            title,
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
}
