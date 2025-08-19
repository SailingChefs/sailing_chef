import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/app/app.router.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DeleteAccountDialogModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final navigationService = locator<NavigationService>();
  final snackbarService = locator<SnackbarService>();
  final userService = locator<UserServices>();

  void deleteAccount() {
    navigationService.back();
    _dialogService.showCustomDialog(variant: DialogType.enterPass);
  }

  bool isGoogleSignInUser(User user) {
    for (final userInfo in user.providerData) {
      if (userInfo.providerId == 'google.com') {
        return true;
      }
    }
    return false;
  }

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> reauthenticateUser(User user) async {
    try {
      if (isGoogleSignInUser(user)) {
        // Re-authenticate Google user
        final googleSignIn = GoogleSignIn.instance;
        final googleUser = await googleSignIn.authenticate();
        final googleAuth = googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          // accessToken: googleAuth.accessToken,
        );
        await user.reauthenticateWithCredential(credential);
      }
    } catch (e) {
      log('Re-authentication failed: $e');
      throw FirebaseAuthException(
        code: 'ERROR_REAUTHENTICATION_FAILED',
        message: 'Re-authentication failed',
      );
    }
  }

  Future<bool> deleteGoogleUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Re-authenticate the user
        await reauthenticateUser(user);

        // Delete the user
        await user.delete();
        log('Google user deleted successfully: ${user.email}');

        // Verify if the user is still signed in
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser == null) {
          showToast(
            message: 'Account Deleted Permanently',
          );
          return true;
        }
        showToast(
          message: 'Account deletion failed',
        );
        return false;
      }
      return false;
    } catch (e) {
      showToast(
        message: 'Account deletion failed',
      );
      log('Failed to delete Google user: $e');
      return false;
    }
  }

  Future<void> sureDeltete() async {
    navigationService.back();
    EasyLoading.show();
    if (FirebaseAuth.instance.currentUser != null) {
      userService.deleteGoogleUserDocument();
      final deleteUser = await deleteGoogleUser();
      if (deleteUser) {
        navigationService.clearStackAndShow(Routes.loginView);
      }
    }
    EasyLoading.dismiss();
  }
}
