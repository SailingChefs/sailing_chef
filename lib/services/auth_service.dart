// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/user_model.dart';
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
      showToast(message: 'Failed to login');
      log(e.toString());
      return false;
    }
  }


void signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    userDetails = null;
  } catch (e) {
    log("Error signing out: $e");
  }
}

  Future<bool> signUp({
    required String password,
    required UserModel userModel,
  }) async {
    try {
      EasyLoading.show();
      // Create user with email and password
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email!,
        password: password,
      );
      userModel.uid = userCredential.user!.uid;
      userDetails = userModel;
      userDetails!.displayName = userModel.displayName;
      // Store user details in Firestore
      bool userStored = await UserServices.storeUserRoleAndName(
        userModel: userModel,
      );

      // Update user profile display name
      await userCredential.user!.updateDisplayName(userModel.displayName);

      UserServices.storeUserRoleAndName(userModel: userModel);
      // Return user ID
      EasyLoading.dismiss();
      showToast(message: 'Signed up successfully');
      return true;
    } catch (e) {
      // Handle signup errors
      debugPrint('Error signing up: $e');
      EasyLoading.dismiss();
      showToast(message: 'Failed to sign up because $e');
      return false;
    }
  }
}

//   static Future<bool> register({
//     required String email,
//     required String password,
//     required String name,
//     required String role,
//   }) async {
//     try {
//       EasyLoading.show();
//       final UserCredential user = await firebaseAuth
//           .createUserWithEmailAndPassword(email: email, password: password);
//       bool userStored = await UserServices.storeUserRoleAndName(
//         uid: user.user!.uid,
//         name: name,
//         role: role,
//       );

//       EasyLoading.dismiss();
//       if (userStored) {
//         showToast(message: 'Registered successfully');
//         return true;
//       } else {
//         showToast(message: 'Failed to register');
//         return false;
//       }
//     } on FirebaseAuthException catch (e) {
//       log(e.code.toString());
//       switch (e.code) {
//         case "email-already-in-use":
//           showToast(message: 'Email already exists');
//         default:
//           showToast(message: 'Failed to register');
//           break;
//       }
//       return false;
//     } catch (e) {
//       EasyLoading.dismiss();

//       return false;
//     }
//   }
