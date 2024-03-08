import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/profile/profile_viewmodel.dart';

class TopBarProfileScreen extends ViewModelWidget<ProfileViewModel> {
  const TopBarProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
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
        GestureDetector(
          onTap: () => viewModel.toSettings(),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 2.0.dg),
            height: 36.h,
            width: 36.w,
            decoration: const BoxDecoration(
              color: kcVeryLightGrey,
              shape: BoxShape.circle,
            ),
            child: Icon(
              FlutterRemix.more_fill,
              color: kcBlackColor,
              size: 20.sp,
            ),
          ),
        ),
      ],
    );
  }
}
