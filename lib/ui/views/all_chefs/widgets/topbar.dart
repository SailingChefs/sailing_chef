import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/all_chefs/all_chefs_viewmodel.dart';

class TopBarMeetChefsScreen extends ViewModelWidget<AllChefsViewModel>
    implements PreferredSizeWidget {
  const TopBarMeetChefsScreen({super.key});

  @override
  Widget build(BuildContext context, AllChefsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: viewModel.back,
            child: Container(
              alignment: Alignment.center,
              height: 26.h,
              width: 26.w,
              child: Icon(
                Icons.arrow_back_ios,
                color: kcBlackColor,
                size: 18.sp,
              ),
            ),
          ),
          Text(
            'Meet Your Chefs',
            style: globalTextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: kcBlackColor),
          ),
          GestureDetector(
            onTap: viewModel.goToAgencyAccessInfo,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                'For agencies',
                style: globalTextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: kcDarkColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
