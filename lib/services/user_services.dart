import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

import '../core/imports/core_imports.dart';
import '../model/user_model.dart';

class UserServices with ListenableServiceMixin {
  UserModel? currentUserDetails;

  final NavigationService _navigationService = locator<NavigationService>();
    final DialogService _dialogService = locator<DialogService>();
  static Future<bool> storeUserRoleAndName({
    required UserModel userModel,
  }) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      // User not signed in or created
      throw Exception("User not signed in or created");
    }

    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    DocumentSnapshot userSnapshot = await usersCollection.doc(user.uid).get();
    userModel.userDocId = userSnapshot.id;

    if (!userSnapshot.exists) {
      await usersCollection.doc(user.uid).set(
            userModel.toJson(),
          );

      return true;
    } else {
      return false;
    }
  }

Future<void> storeUserRole(UserModel userModel) async {
  final user = firebaseAuth.currentUser;
  if (user == null) {
    // User not signed in or created
    throw Exception("User not signed in or created");
  }

  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  QuerySnapshot querySnapshot = await usersCollection
     .where('email', isEqualTo: userModel.email)
     .get();

  if (querySnapshot.docs.isNotEmpty) {
    DocumentSnapshot userSnapshot = querySnapshot.docs.first;
    userModel.userDocId = userSnapshot.id;
    userModel.userRole = userSnapshot.get('user_role');

    if (userModel.userRole == 'guest') {
      _navigationService.replaceWithBottomBarGuestView();
    } else {
      _navigationService.replaceWithBottomNavBarView();
    }
  } else {
    _dialogService.showCustomDialog(
      variant: DialogType.roleDialog,
    );
  }
}

  Future<UserModel> getUserDetails() async {
    try {
      CollectionReference usersCollection = firebasestore.collection('users');

      QuerySnapshot userSnapshot = await usersCollection
          .where('uid', isEqualTo: firebaseAuth.currentUser!.uid)
          .get();

      log(userSnapshot.docs.toString());

      if (userSnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDoc = userSnapshot.docs.first;

        // showToast(message: 'User Data fetched successfully');

        UserModel.fromSnapshot(userDoc);

        // return  UserModel();
        return UserModel.fromSnapshot(userDoc);
      } else {
        throw Exception("User not found in Firestore");
      }
    } catch (e) {
      showToast(message: e.toString());
      // Handle errors as needed
      throw Exception(e.toString());
    }
  }

  Future<bool> storeUserDetails(
      Map<String, dynamic> userModel, String uid) async {
    try {
      EasyLoading.show();
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      DocumentSnapshot userSnapshot = await usersCollection.doc(uid).get();
      log(userSnapshot.exists.toString());
      if (userSnapshot.exists) {
        await usersCollection.doc(uid).update(userModel);
        EasyLoading.dismiss();
        showToast(message: 'User Data Uploaded successfully');
        return true;
      } else {
        EasyLoading.dismiss();
        await usersCollection.doc(uid).set(userModel);
        return true;
      }
    } catch (e) {
      EasyLoading.dismiss();
      showToast(message: e.toString());

      rethrow;
    }
  }

  Future<String> uploadImage(File imageFile, String fileName) async {
    try {
      EasyLoading.show();
      // Create a reference to the location you want to upload the file
      Reference ref = firebaseStorage.ref().child('images/usersDp/$fileName');

      // Upload the file to Firebase Storage
      UploadTask uploadTask = ref.putFile(imageFile);

      // Get the download URL of the uploaded file
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Return the download URL
      EasyLoading.dismiss();
      log(downloadUrl);
      return downloadUrl;
    } catch (e) {
      // Handle errors
      EasyLoading.dismiss();
      showToast(message: 'Error uploading image: $e');
      return '';
    }
  }

  Future<UserModel> fetchUserByUID(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await firebasestore.collection('users').doc(uid).get();
      if (snapshot.exists) {
        return UserModel.fromSnapshot(snapshot);
      } else {
        log('No user found with uid: $uid');
        return UserModel();
      }
    } catch (e) {
      log('Error fetching user: $e');
      return UserModel();
    }
  }

  Future<bool> doesUserExist(String uid) async {
    try {
      final userSnapshot =
          await firebasestore.collection('users').doc(uid).get();
      if (userSnapshot.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Error fetching user: $e');
      return false;
    }
  }

  Future<void> clickOnForgetPassword({required String email}) async {
    try {
      EasyLoading.show();
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      EasyLoading.dismiss();
      showToast(message: "Forgot password link sent to $email");
    } catch (e) {
      EasyLoading.dismiss();
      showToast(message: e.toString());
    }
  }

  Future<bool> checkPassword(String password) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return false;
      }

      // Create credentials with the provided email and password
      AuthCredential credential =
          EmailAuthProvider.credential(email: user.email!, password: password);

      // Re-authenticate the user with the provided credentials
      await user.reauthenticateWithCredential(credential);
      log('User re-authenticated successfully : ${user.email}');
      // If re-authentication is successful, the password is correct
      return true;
    } catch (e) {
      log(e.toString());
      // If an error occurs, the password is incorrect
      return false;
    }
  }

  Future<bool> deleteUserAndDocument(String passworde) async {
    try {
      EasyLoading.show();

      // Re-authenticate the user
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        EasyLoading.dismiss();
        return false;
      }

      // Assuming you have a way to get the user's email and password, prompt the user for these credentials.
      String email = userDetails!.email!; // Get the user's email
      String password = passworde; // Get the user's password

      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      await user.reauthenticateWithCredential(credential);
      // Proceed with the deletion after re-authentication

      QuerySnapshot followingSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('following', arrayContains: user.uid)
          .get();
      for (var doc in followingSnapshot.docs) {
        await doc.reference.update({
          'following': FieldValue.arrayRemove([user.uid])
        });
      }

      // Find all documents where the user UID is in the followers array
      QuerySnapshot followersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('followers', arrayContains: user.uid)
          .get();
      for (var doc in followersSnapshot.docs) {
        await doc.reference.update({
          'followers': FieldValue.arrayRemove([user.uid])
        });
      }
      await FirebaseFirestore.instance
          .collection('conversations')
          .where('users', arrayContains: user.uid)
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.delete();
        }
      });

      await FirebaseFirestore.instance
          .collection('recipes')
          .where('uid', isEqualTo: user.uid)
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.delete();
        }
      });
      QuerySnapshot shopping = await FirebaseFirestore.instance
          .collection('shopping_list')
          .where('user_id', isEqualTo: user.uid)
          .get();
      for (var doc in shopping.docs) {
        await doc.reference.delete();
      }

      await FirebaseFirestore.instance
          .collection('recipes')
          .get()
          .then((recipesSnapshot) async {
        for (var recipeDoc in recipesSnapshot.docs) {
          await FirebaseFirestore.instance
              .collection('recipes')
              .doc(recipeDoc.id)
              .collection('comments')
              .where('uid', isEqualTo: user.uid)
              .get()
              .then((querySnapshot) {
            for (var commentDoc in querySnapshot.docs) {
              commentDoc.reference.delete();
            }
          });
        }
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .delete();

      // if (userDetails!.userRole == 'culinarySchool') {
      //   for (var courseId in userDetails!.schoolCourses!) {
      //     await FirebaseFirestore.instance
      //         .collection('courses')
      //         .doc(courseId)
      //         .delete();
      //   }
      // }

      // Delete user from Firebase Authentication
      await user.delete();
      userDetails = null;
      savedRecipesGlobal = [];

      EasyLoading.dismiss();
      log('User account and document deleted successfully');
      return true;
    } catch (e) {
      EasyLoading.dismiss();
      log('Error deleting user and document: $e');
      return false;
    }
  }
}
