import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/auth_service.dart';

class SettingsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();

  void getBack() {
    _navigationService.back();
  }

  void moveToBecomeChef() {
    _navigationService.navigateToBecomechefView();
  }

  void getToMap() {
    _navigationService.navigateToPinDropMapView();
  }

  void getEditProfile() {
    _navigationService.navigateToEditProfileView();
  }

  void signOutUser() async {
    await _authService.signOut();
    _navigationService.replaceWithLoginView();
  }
}
