import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/rounded_elevated_button.dart';

class TopBarOnboardingScreen extends ViewModelWidget<OnboardingViewModel> {
  const TopBarOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) {
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
          // width: 103.dg,
          height: 34,
          textFontSize: 14.sp,
          textFontWeight: FontWeight.w600,
          textColor: kclightgreencolor,
          onPressed: () {
            viewModel.toLogin();
          },
          buttonText: 'login',
          isEnabled: true,
        ),
      ],
    );
  }
}
