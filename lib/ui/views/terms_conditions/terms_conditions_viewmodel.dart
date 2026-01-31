import 'package:sailing_chefs/core/imports/core_imports.dart';

class TermsConditionsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  @override
  void getBack() {
    _navigationService.back();
  }
}
