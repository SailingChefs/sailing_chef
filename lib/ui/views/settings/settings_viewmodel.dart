import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/auth_service.dart';

class SettingsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();


  void getBack() {
    _navigationService.back();
  }

  void getToMap() {
    _navigationService.navigateToPinDropMapView();
  }

  void signoutUser() {
    AuthService.signout();
    _navigationService.navigateToLoginView();
  }
}
