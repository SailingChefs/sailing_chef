import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/custom_textbtn.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
          effect: SlideEffect(
            radius: 4.0,
            dotWidth: 9.0,
            dotHeight: 9.0,
            strokeWidth: 1.5,
            dotColor: kcBlackColor.withOpacity(0.4),
            activeDotColor: kclightgreencolor,
          ),
        ),
        verticalSpaceSmall,
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
                ),
                Container(
                  height: 1.0,
                  padding: const EdgeInsets.all(0),
                  width: _getTextWidth('sign up', const TextStyle()),
                  color: kcsgreylinecolor,
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
  final textPainter = TextPainter(
    text: TextSpan(text: '$text   ', style: style),
    textDirection: TextDirection.ltr,
  )..layout();
  return textPainter.width;
}
