import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/auth_service.dart';
import 'package:sailing_chefs/ui/views/onboarding/onboarding_view.dart';

class SettingsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _dialogService = locator<DialogService>();

  @override
  void getBack() {
    // if (userDetails!.userRole == 'chef' ||
    //     userDetails!.userRole == 'culinarySchool') {
    //   _navigationService.navigateToBottomNavBarView();
    // } else {
    //   _navigationService.navigateToBottomBarGuestView();
    // }
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

  void getToShoppingList() {
    _navigationService.navigateToShoppingListView();
  }

  void getEditProfile() {
    _navigationService.navigateToEditProfileView();
  }

  void getAllDrafts() {
    _navigationService.navigateToViewAllDraftsView();
  }

  void getPrivacyPolicy() {
    _navigationService.navigateToPrivacyPolicyView();
  }

  void getTermsConditions() {
    _navigationService.navigateToTermsConditionsView();
  }

  Future<void> signOutUser() async {
    await _authService.signOut();
    _navigationService.clearStackAndShowView(const OnboardingView());
  }

  void getSavedRecipes() {
    _navigationService.navigateToCullinarySavedrecipesView();
  }

  void goToPrivateRecipes() {
    _navigationService.navigateToPrivateRecipesView();
  }

  void sendFeedback() {
    _navigationService.navigateToFeedbackView();
  }

  void goToManageRecipes() {
    _navigationService.navigateToManageRecipesView();
  }

  void goToManagePins() {
    _navigationService.navigateToManagePinsView();
  }
}
