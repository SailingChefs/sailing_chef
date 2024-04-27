import 'package:sailing_chefs/services/user_services.dart';

import '../../../core/imports/core_imports.dart';

class ForgetPasswordViewModel extends BaseViewModel {
  final _emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final userService = locator<UserServices>();
  final navigationService = locator<NavigationService>();

  TextEditingController get emailController => _emailController;

  String? validateEmail(String? value) {
    if (value!.isEmpty || value.contains("@gmail.com") == false) {
      return 'Please enter an email address';
    } else {
      return null;
    }
  }

  void sendEmailLink({required String email}) async {
    userService.clickOnForgetPassword(email: email);
    navigationService.back();
  }
}
