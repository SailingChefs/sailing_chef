// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class AuthService {
  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      EasyLoading.show();
      final UserCredential user = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      EasyLoading.dismiss();

      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          showToast(message: 'Invalid email');
        case "user-disabled":
          showToast(message: 'User disabled');
        case "user-not-found":
          showToast(message: 'User not found');
        case "wrong-password":
          showToast(message: 'Wrong password');
        default:
          showToast(message: 'Failed to login');
          break;
      }

      EasyLoading.dismiss();
      return false;
    } catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
      return false;
    }
  }

  static Future<bool> register({
    required String email,
    required String password,
    required String name,
    required String role,
  }) async {
    try {
      EasyLoading.show();
      final UserCredential user = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await UserServices.storeUserRoleAndName(
        uid: user.user!.uid,
        name: name,
        role: role,
      );

      EasyLoading.dismiss();

      return true;
    } on FirebaseAuthException catch (e) {
      log(e.code.toString());
      switch (e.code) {
        case "email-already-in-use":
          showToast(message: 'Email already exists');
        default:
          showToast(message: 'Failed to register');
          break;
      }
      return false;
    } catch (e) {
      EasyLoading.dismiss();

      return false;
    }
  }
}
