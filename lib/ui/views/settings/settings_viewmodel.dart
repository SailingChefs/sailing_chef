import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/auth_service.dart';
import 'package:sailing_chefs/ui/views/login/login_view.dart';

class SettingsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _dialogService = locator<DialogService>();

  void getBack() {
    if(userDetails!.userRole == 'chef' || userDetails!.userRole == 'culinarySchool'){
      _navigationService.navigateToBottomNavBarView();
    }
    else{
      _navigationService.navigateToBottomBarGuestView();
    }
    
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

  void getAllDrafts() {
    _navigationService.navigateToViewAllDraftsView();
  }

  void getTerms() {
    _navigationService.navigateToPrivacyPolicyView();
  }

  void signOutUser() async {
    await  _authService.signOut();
    _navigationService.clearStackAndShowView(const LoginView());
  }
}
