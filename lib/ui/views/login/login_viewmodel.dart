import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/auth_service.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/views/bottom_nav_bar/bottom_nav_bar_viewmodel.dart';

class LoginViewModel extends BaseViewModel {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _userService = locator<UserServices>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void vaigateToForgetPassword() {
    _navigationService.navigateToForgetPasswordView();
  }

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  final _navigationService = locator<NavigationService>();
  bool showPassword = false;
  bool isLoginButtonEnabled() {
    // Add your conditions to enable/disable the login button
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an email address';
    }

    // Use a regular expression for basic email validation
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(value)
        ? null
        : 'Please enter a valid email address';
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }

    // Password should be at least 8 characters long
    return value.length >= 8
        ? null
        : 'Password must be at least 8 characters long';
  }

  void login() async {
    if (formKey.currentState?.validate() ?? false) {
      bool success = await AuthService.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (success) {
        userDetails = await _userService.getUserDetails();
        if (userDetails!.displayPicture == '') {
          _navigationService.replaceWithUserDetailsView(
              userRole: userDetails!.userRole!);
        } else {
          if (userDetails!.userRole == 'guest') {
            locator.removeRegistrationIfExists<BottomNavBarViewModel>();
            locator.registerLazySingleton<BottomNavBarViewModel>(
                () => BottomNavBarViewModel());
            _navigationService.replaceWithBottomBarGuestView();
          } else {
            locator.removeRegistrationIfExists<BottomNavBarViewModel>();
            locator.registerLazySingleton<BottomNavBarViewModel>(
                () => BottomNavBarViewModel());
            _navigationService.replaceWithBottomNavBarView();
          }
        }
      } else {
        _navigationService.replaceWithLoginView();
      }
    } else {
      _navigationService.replaceWithLoginView();
    }
  }

  void passwordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
    rebuildUi();
  }

  void toSignUp() {
    _navigationService.replaceWithSignUpView();
  }

  void signInWithGoogleAccount() async {
    await AuthService().signInWithGoogle();
  }
}
