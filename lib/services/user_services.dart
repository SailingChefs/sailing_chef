import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

import '../model/user_model.dart';

class UserServices {
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
      // User not stored in Firestore, so add their data
      await usersCollection.doc(user.uid).set(
            userModel.toJson(),
          );

      return true;
    } else {
      return false;
    }
  }

  Future<UserModel> getUserDetails() async {
    try {
      EasyLoading.show();
      CollectionReference usersCollection = firebasestore.collection('users');

      QuerySnapshot userSnapshot = await usersCollection
          .where('uid', isEqualTo: firebaseAuth.currentUser!.uid)
          .get();

      log(userSnapshot.docs.toString());

      if (userSnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDoc = userSnapshot.docs.first;
        EasyLoading.dismiss();
        showToast(message: 'User Data fetched successfully');

        return UserModel.fromSnapshot(userDoc);
      } else {
        EasyLoading.dismiss();
        throw Exception("User not found in Firestore");
      }
    } catch (e) {
      EasyLoading.dismiss();
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
}
