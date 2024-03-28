import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void getBack() {
    _navigationService.back();
  }

  void getToMap() {
    _navigationService.navigateToPinDropMapView();
  }
}
