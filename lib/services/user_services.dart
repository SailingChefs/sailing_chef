import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/core/instances.dart';

import '../model/user_model.dart';

class UserServices {
  static Future<void> storeUserRoleAndName({
    required String uid,
    required String name,
    required String role,
  }) async {
    var user = firebaseAuth.currentUser;
    if (user == null) {
      // User not signed in or created
      throw Exception("User not signed in or created");
    }

    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    DocumentSnapshot userSnapshot = await usersCollection.doc(uid).get();

    if (!userSnapshot.exists) {
      // User not stored in Firestore, so add their data
      await usersCollection.doc(uid).set({
        'name': name,
        'role': role,
      });
    } else {
      Null;
    }
  }

 static Future<User> getUserDetails(String uid) async {
    try {
      EasyLoading.show();
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      DocumentSnapshot userSnapshot = await usersCollection.doc(uid).get();

      EasyLoading.dismiss();

      log("User found in Firestore ${userSnapshot.data() as Map<String, dynamic>}");
      if (userSnapshot.exists) {
        // User found in Firestore, return as User model
        return User.fromJson(userSnapshot.data() as Map<String, dynamic>);
      } else {
        // User not found in Firestore
        throw Exception("User not found in Firestore");
      }
    } catch (e) {
      EasyLoading.dismiss();
      // Handle errors as needed
      rethrow;
    }
  }
}
