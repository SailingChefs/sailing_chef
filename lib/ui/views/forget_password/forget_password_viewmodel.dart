import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/user_services.dart';

class ForgetPasswordViewModel extends BaseViewModel {
  final _emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final userService = locator<UserServices>();
  final navigationService = locator<NavigationService>();

  TextEditingController get emailController => _emailController;
  void toLogin() {
    navigationService.replaceWithLoginView();
  }

  bool isSignupButtonEnabled() {
    return emailController.text.isNotEmpty;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an email address';
    }

    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(value)
        ? null
        : 'Please enter a valid email address';
  }

  Future<void> sendEmailLink({required String email}) async {
    await userService.clickOnForgetPassword(email: email);
    navigationService.back();
  }
}
