import 'package:sailing_chefs/ui/widgets/custom_elevatedbtn.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/imports/core_imports.dart';
import '../../widgets/custom_textbtn.dart';
import 'onboarding_viewmodel.dart';

class OnboardingView extends StackedView<OnboardingViewModel> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    OnboardingViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,

      backgroundColor:kcDarkColor.withOpacity(0.8),
      body: Stack(
        children: [
          PageView.builder(
            controller: viewModel.pageController,
            itemCount: viewModel.pages.length,
            onPageChanged: (value) => viewModel.setCurrentIndex(value),
            itemBuilder: (context, index) {
              return Stack(
                // alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        viewModel.pages[index].image,
                        height: screenHeight(context),
                        fit: BoxFit.fill,
                        width:double.infinity,
                      ),
                    ],
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            verticalSpaceMassive,
                            verticalSpaceMassive,
                            verticalSpaceMassive,
                            verticalSpaceLarge,
                            Text(
                              viewModel.pages[viewModel.currentPage].title,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: globalTextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600,
                                color: kcPrimaryColor,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              viewModel
                                  .pages[viewModel.currentPage].description,
                              textAlign: TextAlign.center,
                              style: globalTextStyle(
                                fontSize: 16.sp,
                                color: kcPrimaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            verticalSpaceLarge,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned.fill(
              child: SizedBox(
            height: screenHeight(context),
            width: screenWidth(context),
            child: Padding(
              padding: EdgeInsets.only(top: 35.0.dg, left: 20.dg, right: 20.dg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/logo/SAILING CHEFS.png',
                         width: 130.w,
                        height: 70.h,
                      ),
                      CustomElevatedButton(
                        onPressed: viewModel.toLogin,
                        buttonText: 'Login',
                        width: 80.dg,
                        height: getResponsiveMediumFontSize(context),
                        textFontSize: 10.sp,
                        isEnabled: true,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SmoothPageIndicator(
                        controller: viewModel.pageController,
                        count: 3,
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
                  ),
                ],
              ),
            ),
          )),
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
