// ignore_for_file: deprecated_member_use
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/auth_service.dart';

import 'package:sailing_chefs/ui/common/show_toast.dart';

class SignUpViewModel extends BaseViewModel {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _authService = locator<AuthService>();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  TextEditingController get textController => _nameController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get emailController => _emailController;

  final _navigationService = locator<NavigationService>();
  bool showPassword = false;

  bool isSignupButtonEnabled() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        textController.text.isNotEmpty;
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

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your name';
    }
    return value.length >= 3 ? null : 'Name must be at least 3 characters long';
  }

  String? Function(String?)? validatePassword = (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    return value.length >= 8
        ? null
        : 'Password must be at least 8 characters long';
  };

  Future<void> signup() async {
    if (formKey.currentState?.validate() ?? false) {
      if (selectedSignUpAs.isEmpty) {
        showToast(message: 'Please Select a role');
        return;
      }
      final signupUser = UserModel(
        displayName: textController.text.trim(),
        email: emailController.text.trim(),
        userRole: selectedSignUpAs,
        uid: '',
        bio: '',
        boatName: '',
        createdTime: DateTime.now(),
        displayPicture: '',
        followers: [],
        following: [],
        link: '',
        savedRecipes: [],
        blockedAccounts: [],
      );
      final userRegistered = await _authService.signUp(
          password: passwordController.text.trim(), userModel: signupUser);

      if (userRegistered) {
        _navigationService.replaceWithUserDetailsView(
            userRole: selectedSignUpAs);
      } else {
        _navigationService.replaceWithSignUpView();
      }
    } else {
      _navigationService.replaceWithSignUpView();
    }
  }

  void passwordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void toLogin() {
    _navigationService.replaceWithLoginView();
  }

  String selectedSignUpAs = '';

  void handleSignUpAs(int index) {
    switch (index) {
      case 0:
        selectedSignUpAs = 'guest';
      case 1:
        selectedSignUpAs = 'culinarySchool';
      case 2:
        selectedSignUpAs = 'chef';
      case 3:
        selectedSignUpAs = 'supplier';
      default:
        break;
    }
    rebuildUi();
  }
}
