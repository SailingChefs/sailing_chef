import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/auth_service.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class EnterPassDialogModel extends BaseViewModel {
  final _userService = locator<UserServices>();
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = false;
  void passwordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
    rebuildUi();
  }

  void vaigateToForgetPassword() {
    _navigationService.navigateToForgetPasswordView();
  }

  Future<void> deleteAccount() async {
    final check = await _userService.checkPassword(passwordController.text);

    if (check) {
      final deleted =
          await _userService.deleteUserAndDocument(passwordController.text);

      deleted
          ? showToast(
              message: 'Account Deleted Permanently',
            )
          : showToast(message: 'Account Deletion was interrupted');

      if (deleted) {
        await _authService.signOut();
        _navigationService.replaceWithLoginView();
      }
    } else {
      showToast(message: 'Wrong Password');
    }
  }
}
