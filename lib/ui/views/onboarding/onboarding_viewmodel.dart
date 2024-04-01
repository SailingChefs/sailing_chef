import '../../../core/imports/core_imports.dart';
import '../../../model/onboard_model.dart';

class OnboardingViewModel extends BaseViewModel {
  final PageController pageController = PageController();
  final _navigationServices = locator<NavigationService>();

  int currentPage = 0;
  final List<OnboardModel> pages = [
    OnboardModel(
      image: 'assets/images/background/onboarding1.png',
      title: 'Discovering seagoing chefs and their best recipes.',
      description:
          'Follow your favorite chefs, save recipes and connect with those that inspire you.',
    ),
    OnboardModel(
      image: 'assets/images/background/onboarding2.png',
      title: 'Join as a chef',
      description:
          'Upload and share your recipes. Connect with crew, guests and provisioners. Showcase your creations and make it what you want.',
    ),
    OnboardModel(
      image: 'assets/images/background/onboarding3.png',
      title: 'Join as a culinary school',
      description:
          ' Seeking inspiration for your next meal or looking to recruit the best chefs. ',
    ),
    OnboardModel(
      image: 'assets/images/background/onboarding4.png',
      title: 'Join as a guest',
      description:
          ' Seeking inspiration for your next meal or looking to recruit the best chefs. ',
    ),
  ];

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
