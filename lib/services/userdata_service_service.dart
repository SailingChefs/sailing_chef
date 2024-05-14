import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class UserdataServiceService {
  static UserModel user = UserModel();
  Future<List<UserModel>> fetchUsersDocuments() async {
    List<UserModel> users = [];

    try {
      EasyLoading.show();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: firebaseAuth.currentUser?.uid)
          .get();

      for (var doc in querySnapshot.docs) {
        user = UserModel.fromSnapshot(doc);
        users.add(user);
      }

      EasyLoading.dismiss();

      return users;
    } catch (error) {
      EasyLoading.dismiss();
      return users;
    }
  }

  Future<void> deleteFileFromStorage(String downloadUrl) async {
    try {
      // Extract the file path from the download URL
      String filePath = Uri.decodeFull(Uri.parse(downloadUrl).path);

      // Remove the leading '/' from the file path
      filePath = filePath.substring(38);
      log(filePath);

      // Get a reference to the file in Firebase Storage
      Reference storageRef = FirebaseStorage.instance.ref().child(filePath);

      // Delete the file
      await storageRef.delete();
      log('File deleted successfully');
    } catch (error) {
      log('Error deleting file: $error');
      // Handle error as needed
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
}
