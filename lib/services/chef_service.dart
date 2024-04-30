
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/user_services.dart';

import '../app/app.locator.dart';

class ChefService {
  final _userService = locator<UserServices>();
  List<UserModel> chefs = [];
  bool isInitialized = false;

  Future<void> chefInit() async {
    if (isInitialized) return;
    chefs = await _fetchChefDocuments();
    isInitialized = true;
  }


  Future<List<UserModel>> _fetchChefDocuments() async {
    List<UserModel> users = [];
  

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where(
            'user_role',
            isEqualTo: 'chef',
          )
          .where('uid', isNotEqualTo: firebaseAuth.currentUser?.uid)
          .get();

      for (var doc in querySnapshot.docs) {
        UserModel? currUser = await _userService
            .fetchUserByUID(FirebaseAuth.instance.currentUser!.uid);
        UserModel user = UserModel.fromSnapshot(doc);
        if (!currUser.blockedAccounts!.contains(user.uid)) {
          users.add(user);
        }
      }

      return users;
    } catch (error) {
      // Handle any errors
      EasyLoading.dismiss();
      return users; // Return an empty list in case of error
    }
  }
}
