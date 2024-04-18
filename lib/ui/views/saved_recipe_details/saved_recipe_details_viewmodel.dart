import 'dart:async';

import '../../../core/imports/core_imports.dart';

class SavedRecipeDetailsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  // final PageController pageController = PageController();
  String selectedTab = 'Ingredients';
  bool isIngredientsSelected = true;
  bool isMethodsSelected = false;
   final PageController pageController = PageController();
  Timer? _timer;

  void startAutoScroll(int length) {
    const duration = Duration(seconds: 3); // Change the interval as needed
    _timer = Timer.periodic(duration, (Timer timer) {
      if (pageController.hasClients) {
        int nextPage = pageController.page!.toInt() + 1;
        if (nextPage >= length) {
          nextPage = 0;  // Loop back to the first image
        }
        pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void stopAutoScroll() {
    _timer?.cancel();
  }

  void showNextImage(int length) {
    if (pageController.hasClients) {
      int nextPage = (pageController.page!.toInt() + 1) % length;
      pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void showPreviousImage(int length) {
    if (pageController.hasClients) {
      int previousPage = pageController.page!.toInt() - 1;
      if (previousPage < 0) {
        previousPage = length - 1; // Loop to last image
      }
      pageController.animateToPage(
        previousPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void myIngredientsSelected() {
    isIngredientsSelected = true;
    isMethodsSelected = false;
    notifyListeners();
    rebuildUi();
    
  }
  // void showPreviousImage() {
  //   if (pageController.page! > 0) {
  //     pageController.previousPage(
  //         duration: const Duration(milliseconds: 300), curve: Curves.ease);
  //   }
  // }
  // // Function to handle swipe to the left (show next image)
  // void showNextImage(int length) {
  //   if (pageController.page! < length - 1) {
  //     pageController.nextPage(
  //         duration: const Duration(milliseconds: 300), curve: Curves.ease);
  //   }
  // }

  void methodsSelected() {
    isMethodsSelected = true;
    isIngredientsSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void moveBack() {
    _navigationService.back();
    
  }

  void moveToChefProfileView() {
    // _navigationService.navigateToChefProfileView();
  }

  void handleTab(int index) {
    switch (index) {
      case 0:
        selectedTab = 'Ingredients';
        break;
      case 1:
        selectedTab = 'Method';
        break;

      default:
        break;
    }

    rebuildUi();
  }

  // void addServes() {
  //   serves++;
  //   rebuildUi();
  //   notifyListeners();
  // }

  // void removeServes() {
  //   if (serves == 0) {
  //     serves = 0;
  //   } else {
  //     serves--;
  //   }

  //   rebuildUi();
  //   notifyListeners();
  // }
  void onViewModelReady(int length) {
    setBusy(true);
    startAutoScroll(length);
    setBusy(false);
  }
  @override
  void dispose() {
    stopAutoScroll();
    pageController.dispose();
    super.dispose();
  }
}
