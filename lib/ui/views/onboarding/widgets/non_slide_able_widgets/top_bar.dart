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
        Image.asset(
          'assets/images/logo/SAILING CHEFS.png',
          width: 130.w,
          height: 70.h,
        ),
        RoundedElevatedButton(
          onPressed: viewModel.toLogin,
          buttonText: 'Login',
          width: 80.dg,
          height: getResponsiveMediumFontSize(context),
          textFontSize: 10.sp,
          isEnabled: true,
        ),
      ],
    );
  }
}
