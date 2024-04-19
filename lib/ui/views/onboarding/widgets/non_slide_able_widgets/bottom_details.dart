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
          effect: SlideEffect(
            spacing: 8.0,
            radius: 4.0,
            dotWidth: 9.0,
            dotHeight: 9.0,
            strokeWidth: 1.5,
            dotColor: kcBlackColor.withOpacity(0.4),
            activeDotColor: kclightgreencolor,
          ),
        ),
        verticalSpaceMedium,
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 22, right: 20, top: 20, bottom: 25),
            child: Column(
              children: [
                CustomTextButton(
                  onPressed: () {
                    viewModel.tosignUp();
                  },
                  buttonText: 'sign up',
                  fontWeight: FontWeight.w400,
                ),
                Container(
                  height: 0.3,
                  padding: const EdgeInsets.all(0),
                  width: _getTextWidth('sign up', const TextStyle()),
                  color: kclightgreycolor,
                ),
                verticalSpaceSmall,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

double _getTextWidth(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
  )..layout();
  return textPainter.width;
}
