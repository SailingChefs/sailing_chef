import 'dart:developer';

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

  void blockAccount(String uid) {
    log("In Block Account");
    _dialogService.showCustomDialog(
      variant: DialogType.blockAccount,
      data: uid,
    );
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
