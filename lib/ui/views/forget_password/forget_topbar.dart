import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/forget_password/forget_password_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/rounded_elevated_button.dart';

class ForgetPasswordTopBar extends ViewModelWidget<ForgetPasswordViewModel> {
  const ForgetPasswordTopBar({super.key});

  @override
  Widget build(BuildContext context, ForgetPasswordViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 150.w,
          height: 80.h,
          child: Image.asset(
            'assets/images/logo/SAILING CHEFS.png',
          ),
        ),
        RoundedElevatedButton(
          width: screenWidth(context) * 0.3,
          height: 34,
          textFontSize: 14.sp,
          textFontWeight: FontWeight.w600,
          textColor: kcPrimaryColor,
          onPressed: viewModel.toLogin,
          buttonText: 'login',
          isEnabled: true,
        ),
      ],
    );
  }
}
