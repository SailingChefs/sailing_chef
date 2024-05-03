import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/user_services.dart';

class CullinaryschoolService {
  final _userService = locator<UserServices>();
  List<UserModel> cullinaryscools = [];
  bool isInitialized = false;

  Future<void> culinaryInit() async {
    cullinaryscools = await _fetchCulinaryDocuments();
  }

  Future<List<UserModel>> _fetchCulinaryDocuments() async {
    List<UserModel> users = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where(
            'user_role',
            isEqualTo: 'culinarySchool',
          )
          .where('uid', isNotEqualTo: FirebaseAuth.instance.currentUser?.uid)
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
      EasyLoading.dismiss();
      return users;
    }
  }
}
