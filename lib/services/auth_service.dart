import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class AuthService {
  final userService = locator<UserServices>();
  final navigationService = locator<NavigationService>();
  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      EasyLoading.show();
      final user = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      if (!user.user!.emailVerified) {
        EasyLoading.dismiss();
        showToast(message: 'Please verify your email before logging in');
        return false;
      }

      EasyLoading.dismiss();
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          showToast(message: 'Invalid email');
        case 'user-disabled':
          showToast(message: 'User disabled');
        case 'user-not-found':
          showToast(message: 'User not found');
        case 'wrong-password':
          showToast(message: 'Wrong password');
        case 'network-request-failed':
          showToast(message: 'No internet connection');
        case 'too-many-requests':
          showToast(message: 'Too many requests');
        case 'email-already-in-use':
          showToast(message: 'Email already in use');
        default:
          showToast(
              message:
                  'Failed to login, Your email might not be verified or password might be incorrect');
      }
      EasyLoading.dismiss();
      return false;
    } catch (e) {
      EasyLoading.dismiss();
      showToast(message: 'Failed to login');
      log(e.toString());
      return false;
    }
  }

  Future<void> signOut() async {
    EasyLoading.show();
    try {
      await firebaseAuth.signOut();
      await GoogleSignIn.instance.signOut();
      userDetails = null;
      savedRecipesGlobal = [];
      EasyLoading.dismiss();
      showToast(message: 'Signed out successfully');
    } catch (e) {
      EasyLoading.dismiss();
      showToast(message: 'Failed to sign out');
      log('Error signing out: $e');
    }
  }

  Future<bool> signUp({
    required String password,
    required UserModel userModel,
  }) async {
    try {
      EasyLoading.show();
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email!,
        password: password,
      );

      userModel.uid = userCredential.user!.uid;
      userDetails = userModel;
      userDetails!.displayName = userModel.displayName;

      await userCredential.user!.updateDisplayName(userModel.displayName);
      await userCredential.user!.sendEmailVerification();

      await userService.storeUserDetails(userModel.toJson(), userCredential.user!.uid);

      EasyLoading.dismiss();
      showToast(
          message:
              'A verification email has been sent to your email address. Please verify your email.');

      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          showToast(message: 'Invalid email');
        case 'network-request-failed':
          showToast(message: 'Weak connection, Please try again');
        case 'too-many-requests':
          showToast(message: 'Too many requests');
        case 'email-already-in-use':
          showToast(message: 'Email already in use');
        default:
          showToast(message: 'Failed to login, Your email might not be verified');
      }
      EasyLoading.dismiss();
      return false;
    } catch (e) {
      debugPrint('Error signing up: $e');

      EasyLoading.dismiss();
      showToast(message: 'Failed to sign up because $e');
      return false;
    }
  }

  Future<void> signInWithGoogle() async {
    final dialogService = locator<DialogService>();
    final googleUser = await GoogleSignIn.instance.authenticate();
    final googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      // accessToken: googleAuth?.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    final user = userCredential.user;

    if (user != null) {
      userDetails = UserModel(
        uid: user.uid,
        userRole: '',
        email: user.email,
        displayName: user.displayName,
        displayPicture: user.photoURL,
        following: [],
        followers: [],
        savedRecipes: [],
        blockedAccounts: [],
        createdTime: DateTime.now(),
        link: '',
        bio: '',
        boatName: '',
        schoolCourses: [],
        recipes: [],
      );

      if (userCredential.additionalUserInfo!.isNewUser) {
        await userService.storeUserDetails(userDetails!.toJson(), userDetails!.uid!);
        dialogService.showCustomDialog(
          variant: DialogType.roleDialog,
        );
      } else {
        userDetails = await userService.fetchUserByUID(user.uid);
        await userService.storeUserDetails(userDetails!.toJson(), userDetails!.uid!);
        navigationService.replaceWithBottomNavBarView();
      }

      // else if (userDetails!.userRole == 'guest') {
      //   userDetails!.userRole = 'guest';
      //   final res = await userService.storeUserDetails(
      //       userDetails!.toJson(), userDetails!.uid!);
      //   navigationService.replaceWithBottomBarGuestView();
      // } else {
      //   userDetails!.userRole = 'guest';
      //   final res = await userService.storeUserDetails(
      //       userDetails!.toJson(), userDetails!.uid!);
      //   navigationService.replaceWithBottomNavBarView();
      // }
    }
  }
}
