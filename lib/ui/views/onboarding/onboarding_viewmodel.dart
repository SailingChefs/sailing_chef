import 'package:sailing_chefs/model/onboard_model.dart';

import '../../../core/imports/core_imports.dart';

class OnboardingViewModel extends BaseViewModel {
  final PageController pageController = PageController();
  final _navigationServices = locator<NavigationService>();

  int currentPage = 0;
  final List<OnboardModel> pages;

  OnboardingViewModel() : pages = _initializeOnboardPages();
  static List<String> descriptions = [
    'Follow your favorite chefs, save recipes and connect with those that inspire you.',
    'Upload and share your recipes. Connect with crew, guests and provisioners. Showcase your creations and make it what you want.',
    'Seeking inspiration for your next meal or looking to recruit the best chefs.',
    'Seeking inspiration for your next meal or looking to recruit the best chefs.',
  ];

  static List<OnboardModel> _initializeOnboardPages() {
    List<OnboardModel> pages = [
      OnboardModel(
        image: 'assets/images/background/onboarding1.png',
        title: 'Discovering seagoing chefs and their best recipes.',
        description: descriptions[0]
      ),
      OnboardModel(
        image: 'assets/images/background/onboarding2.png',
        title: 'Join as a chef',
        description:  descriptions[1]
      ),
      OnboardModel(
        image: 'assets/images/background/onboarding3.png',
        title: 'Join as a culinary school',
         description:  descriptions[2]
      ),
      OnboardModel(
        image: 'assets/images/background/onboarding4.png',
        title: 'Join as a guest',
         description:  descriptions[3]
      ),
    ];

    for (var model in pages) {
      model.getFormattedDescription();
    }

    return pages;
  }

  void setCurrentIndex(int index) {
    currentPage = index;
    rebuildUi();
  }

  void toLogin() {
    _navigationServices.navigateToLoginView();
  }

  void tosignUp() {
    _navigationServices.navigateToSignUpView();
  }

  void toHome() {
    _navigationServices.replaceWithIndexView();
  }

  void next() {
    if (currentPage < 3) {
      currentPage++;
      pageController.animateToPage(
        currentPage,
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeInOut,
      );
    }
    rebuildUi();
  }

  void previous() {
    if (currentPage > 0) {
      currentPage--;
      pageController.animateToPage(
        currentPage,
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeInOut,
      );
    }
    rebuildUi();
  }

  void skip() {
    currentPage = pages.length - 1;
    pageController.animateToPage(
      currentPage,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeInOut,
    );
    rebuildUi();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
