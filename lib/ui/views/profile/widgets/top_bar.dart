import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/profile/profile_viewmodel.dart';

class TopBarProfileScreen extends ViewModelWidget<ProfileViewModel>
    implements PreferredSizeWidget {
  const TopBarProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return Column(
      children: [
        verticalSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            // Container(
            //   alignment: Alignment.center,
            //   padding: EdgeInsets.only(left: 8.0.dg),
            //   height: 36.h,
            //   width: 36.w,
            //   decoration: const BoxDecoration(
            //     color: kcVeryLightGrey,
            //     shape: BoxShape.circle,
            //   ),
            //   child: Icon(
            //     Icons.arrow_back_ios,
            //     color: kcBlackColor,
            //     size: 20.sp,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: viewModel.toSettings,
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
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
