import 'package:sailing_chefs/core/imports/core_imports.dart';

class AdminViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void getBack() {
    _navigationService.back();
  }
}
