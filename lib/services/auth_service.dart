import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _dialogService = locator<DialogService>();
  final userService = locator<UserServices>();
  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      EasyLoading.show();
      final UserCredential user = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (!user.user!.emailVerified) {
        EasyLoading.dismiss();
        showToast(message: 'Please verify your email before logging in');
        return false;
      }

      EasyLoading.dismiss();
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          showToast(message: 'Invalid email');
          break;
        case "user-disabled":
          showToast(message: 'User disabled');
          break;
        case "user-not-found":
          showToast(message: 'User not found');
          break;
        case "wrong-password":
          showToast(message: 'Wrong password');
          break;
        case 'network-request-failed':
          showToast(message: 'No internet connection');
          break;
        case 'too-many-requests':
          showToast(message: 'Too many requests');
          break;
        case 'email-already-in-use':
          showToast(message: 'Email already in use');
          break;
        default:
          showToast(
              message:
                  'Failed to login, Your email might not be verified or password might be incorrect');
          break;
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
      await GoogleSignIn().signOut();
      userDetails = null;
      savedRecipesGlobal = [];
      EasyLoading.dismiss();
      showToast(message: 'Signed out successfully');
    } catch (e) {
      EasyLoading.dismiss();
      showToast(message: 'Failed to sign out');
      log("Error signing out: $e");
    }
  }

  Future<bool> signUp({
    required String password,
    required UserModel userModel,
  }) async {
    try {
      EasyLoading.show();
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email!,
        password: password,
      );

      userModel.uid = userCredential.user!.uid;
      userDetails = userModel;
      userDetails!.displayName = userModel.displayName;

      bool userStored = await UserServices.storeUserRoleAndName(
        userModel: userModel,
      );

      await userCredential.user!.updateDisplayName(userModel.displayName);
      await userCredential.user!.sendEmailVerification();

      EasyLoading.dismiss();
      showToast(
          message:
              'A verification email has been sent to your email address. Please verify your email.');

      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          showToast(message: 'Invalid email');
          break;
        case 'network-request-failed':
          showToast(message: 'Weak connection, Please try again');
          break;
        case 'too-many-requests':
          showToast(message: 'Too many requests');
          break;
        case 'email-already-in-use':
          showToast(message: 'Email already in use');
          break;
        default:
          showToast(
              message: 'Failed to login, Your email might not be verified');
          break;
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
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final User? user = userCredential.user;

    if (user != null) {
      userDetails = UserModel(
        uid: user.uid,
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

      final res = await userService.storeUserDetails(
          userDetails!.toJson(), userDetails!.uid!);

      if (res) {
        dialogService.showCustomDialog(
          variant: DialogType.roleDialog,
        );
      }
    }
  }
}
