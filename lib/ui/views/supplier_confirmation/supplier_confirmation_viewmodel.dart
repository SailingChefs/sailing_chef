import 'package:sailing_chefs/core/imports/core_imports.dart';

class SupplierConfirmationViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void goToSupplierHome() {
    _navigationService.replaceWithSupplierBottomNavView();
  }
}
