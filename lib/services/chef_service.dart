import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/user_model.dart';

class ChefService {

  Future<List<UserModel>> fetchChefDocuments() async {
    log("Here is me........");
    List<UserModel> users = [];

    try {
      EasyLoading.show();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where(
            'user_role',
            isEqualTo: 'chef',
          )
          .where('uid', isNotEqualTo: firebaseAuth.currentUser?.uid)
          .get();

      for (var doc in querySnapshot.docs) {
        // Convert each document snapshot to a UserModel object
        UserModel user = UserModel.fromSnapshot(doc);
        users.add(user);
      }

      EasyLoading.dismiss();

      return users;
    } catch (error) {
      // Handle any errors
      EasyLoading.dismiss();
      return users; // Return an empty list in case of error
    }
  }
}
