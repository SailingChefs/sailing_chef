import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:sailing_chefs/ui/views/onboarding/widgets/non_slide_able_widgets/non_slideable_widgets.dart';

class OnboardingView extends StackedView<OnboardingViewModel> {
  const OnboardingView({super.key});
  @override
  Widget builder(
    BuildContext context,
    OnboardingViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: kcDarkColor.withOpacity(0.8),
      body: Stack(
        children: [
          PageView.builder(
            controller: viewModel.pageController,
            itemCount: viewModel.pages.length,
            onPageChanged: (value) => viewModel.setCurrentIndex(value),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Image.asset(
                    viewModel.pages[index].image,
                    height: screenHeight(context),
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                  Positioned.fill(
                    child: Container(
                      height: screenHeight(context),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/background/back.png'),
                              fit: BoxFit.fill)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          child: Column(
                            children: [
                              verticalSpace(450.h),
                              Text(
                                viewModel.pages[viewModel.currentPage].title,
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: globalTextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2.h,
                                  color: kcWhiteColor,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              viewModel.getFormattedDescription(index),
                              verticalSpaceLarge,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const NonSLideableWidgetOnBoardingScreen()
        ],
      ),
    );
  }

  @override
  OnboardingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OnboardingViewModel();
}
