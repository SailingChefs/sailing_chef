import 'package:sailing_chefs/core/instances.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  bool isFirstTime = false;
  final _navigationService = locator<NavigationService>();

  Future<bool> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('first_time') ?? true;

    if (isFirstTime) {
      await prefs.setBool('first_time', false);
    }

    return isFirstTime;
  }

  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));
    checkFirstTime().then((isFirstTime) {
      if (isFirstTime) {
        _navigationService.replaceWithOnboardingView();
      } else {
        if (firebaseAuth.currentUser == null) {
          _navigationService.replaceWithOnboardingView();
        } else {
          _navigationService.replaceWithBottomBarGuestView();
        }
      }
    });
  }
}
