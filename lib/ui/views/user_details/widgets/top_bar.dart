import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/user_details/user_details_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/custom_textbtn.dart';

class TopBarUserDetailsScreen extends ViewModelWidget<UserDetailsViewModel> {
  const TopBarUserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, UserDetailsViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // GestureDetector(
        //   onTap: () => viewModel.moveBack(),
        //   child: Container(
        //     alignment: Alignment.center,
        //     padding: EdgeInsets.only(left: 8.0.dg),
        //     height: 36.h,
        //     width: 36.w,
        //     decoration: const BoxDecoration(
        //       color: kcVeryLightGrey,
        //       shape: BoxShape.circle,
        //     ),
        //     child: Icon(
        //       Icons.arrow_back_ios,
        //       color: kcPrimaryColor,
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
        CustomTextButton(
          onPressed: () {
            // viewModel.skipToHome();
          },
          buttonText: '',
          textColor: Colors.black.withOpacity(0.6),
        ),
      ],
    );
  }
}
