import 'package:sailing_chefs/core/imports/core_imports.dart';

class PrivacyPolicyViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  @override
  void getBack() {
    _navigationService.back();
  }
}
