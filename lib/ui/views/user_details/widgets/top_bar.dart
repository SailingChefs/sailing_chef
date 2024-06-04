import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/user_details/user_details_viewmodel.dart';

class TopBarUserDetailsScreen extends ViewModelWidget<UserDetailsViewModel> {
  const TopBarUserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, UserDetailsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          // GestureDetector(
          //   onTap: () {
          //     // viewModel.getBack();
          //   },
          //   child: Container(
          //     alignment: Alignment.center,
          //     padding: EdgeInsets.only(left: 8.0.dg),
          //     height: 30.h,
          //     width: 30.w,
          //     decoration: const BoxDecoration(
          //       color: kcVeryLightGrey,
          //       shape: BoxShape.circle,
          //     ),
          //     child: Icon(
          //       Icons.arrow_back_ios,
          //       color: kcBlackColor,
          //       size: 20.sp,
          //     ),
          //   ),
          // ),
          Text(
            'Your Profile',
            style: globalTextStyle(
                fontSize: 20.0.dg,
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.w700),
          ),
          const SizedBox()
          // CustomTextButton(
          //   onPressed: () {
          //     // viewModel.skipToHome();
          //   },
          //   buttonText: 'Skip',
          //   textColor: Colors.black.withOpacity(0.6),
          // ),
        ],
      ),
    );
  }
}
