import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../widgets/custom_textbtn.dart';

class BottomDetailsOnboardingScreen
    extends ViewModelWidget<OnboardingViewModel> {
  const BottomDetailsOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) {
    return Column(
      children: [
        SmoothPageIndicator(
          controller: viewModel.pageController,
          count: 4,
          axisDirection: Axis.horizontal,
          effect: const SlideEffect(
            spacing: 8.0,
            radius: 4.0,
            dotWidth: 8.0,
            dotHeight: 8.0,
            strokeWidth: 1.5,
            dotColor: Colors.grey,
            activeDotColor: kcDarkColor,
          ),
        ),
        verticalSpaceMedium,
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.all(20.0.dg),
            child: CustomTextButton(
              onPressed: () {
                viewModel.tosignUp();
              },
              buttonText: 'SignUp',
            ),
          ),
        ),
      ],
    );
  }
}
