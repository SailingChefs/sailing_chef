import 'package:sailing_chefs/core/imports/core_imports.dart';

class SettingsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void getBack() {
    _navigationService.back();
  }

  void getToMap() {
    _navigationService.navigateToPinDropMapView();
  }
}
