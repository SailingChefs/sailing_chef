import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/auth_service.dart';

class SettingsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _dialogService = locator<DialogService>();

  void getBack() {
    _navigationService.back();
  }

  void deleteAccount() {
    _dialogService.showCustomDialog(variant: DialogType.deleteAccount);
  }

  void getBlockAcc() {
    _navigationService.navigateToBlockedAccountsView();
  }

  void getBecomeChef() {
    _navigationService.navigateToBecomechefView();
  }

  void getToMap() {
    _navigationService.navigateToPinDropMapView();
  }

  void getEditProfile() {
    _navigationService.navigateToEditProfileView();
  }

  void getTerms() {
    _navigationService.navigateToPrivacyPolicyView();
  }

  void signOutUser() {
    _authService.signOut();
    _navigationService.replaceWithLoginView();
  }
}
