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
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

      QuerySnapshot userSnapshot = await usersCollection.where('uid', isEqualTo: firebaseAuth.currentUser!.uid).get();

   

      if (userSnapshot.docs.isNotEmpty) {
        // User found in Firestore, return as User model
        DocumentSnapshot userDoc = userSnapshot.docs.first;
           EasyLoading.dismiss();
        return UserModel.fromSnapshot(userDoc);
      } else {
        // User not found in Firestore
           EasyLoading.dismiss();
        throw Exception("User not found in Firestore");
      }
    } catch (e) {
      EasyLoading.dismiss();
      // Handle errors as needed
      rethrow;
    }
  }
  Future<bool> storeUserDetails(Map<String , dynamic> userModel,String uid) async {
    try {
      EasyLoading.show();
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      DocumentSnapshot userSnapshot = await usersCollection.doc(uid).get();
      if (userSnapshot.exists) {
        // User not stored in Firestore, so add their data
       
        await usersCollection.doc(uid).update(userModel);
        EasyLoading.dismiss();
        showToast(message: 'User Data Uploaded successfully');
        return true;
      } else {
        EasyLoading.dismiss();
        showToast(message: 'User already exists');
        return false;
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
      Reference ref = firebaseStorage.ref().child('images/$fileName');

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
}
