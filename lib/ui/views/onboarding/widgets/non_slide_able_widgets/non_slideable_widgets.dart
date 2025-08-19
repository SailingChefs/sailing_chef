import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:sailing_chefs/ui/views/onboarding/widgets/non_slide_able_widgets/bottom_details.dart';
import 'package:sailing_chefs/ui/views/onboarding/widgets/non_slide_able_widgets/top_bar.dart';

class NonSLideableWidgetOnBoardingScreen
    extends ViewModelWidget<OnboardingViewModel> {
  const NonSLideableWidgetOnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) {
    return Positioned.fill(
        child: SizedBox(
      height: screenHeight(context),
      width: screenWidth(context),
      child: Padding(
        padding: EdgeInsets.only(top: 35.0.dg, left: 20.dg, right: 20.dg),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TopBarOnboardingScreen(),
            BottomDetailsOnboardingScreen(),
          ],
        ),
      ),
    ));
  }
}
