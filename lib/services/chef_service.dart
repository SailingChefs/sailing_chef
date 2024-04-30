import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/user_services.dart';

import '../app/app.locator.dart';

class ChefService {
  final _userService = locator<UserServices>();

//   Future<List<UserModel>> fetchChefDocuments() async {
//   List<UserModel> users = [];
//   final currentUserUid = firebaseAuth.currentUser?.uid;

//   try {
//     EasyLoading.show();
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .where('user_role', isEqualTo: 'chef')
//         .get();

//     for (var doc in querySnapshot.docs) {
//       if (doc.id != currentUserUid) {  // Check if document is not the current user
//         UserModel user = UserModel.fromSnapshot(doc);
//         users.add(user);
//       }
//     }

//     EasyLoading.dismiss();
//     return users;
//   } catch (error) {
//     // Handle any errors
//     EasyLoading.dismiss();
//     log('Error fetching chef documents: $error' );
//     return users; // Return an empty list in case of error
//   }
// }
// Future<List<UserModel>> fetchChefDocuments() async {
//   List<UserModel> users = [];
//   final currentUserUid = firebaseAuth.currentUser?.uid;

//   try {
//     EasyLoading.show();
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .where('user_role', isEqualTo: 'chef')
//         .get();

//     for (var doc in querySnapshot.docs) {
//       if (doc.id != currentUserUid && hasCompleteProfile(doc)) {  // Check if document is not the current user and has complete profile
//         UserModel user = UserModel.fromSnapshot(doc);
//         users.add(user);
//       }
//     }

//     EasyLoading.dismiss();
//     return users;
//   } catch (error) {
//     // Handle any errors
//     EasyLoading.dismiss();
//     print('Error fetching chef documents: $error');
//     return users; // Return an empty list in case of error
//   }
// }

// bool hasCompleteProfile(QueryDocumentSnapshot doc) {
//   var data = doc.data() as Map<String, dynamic>;
//   // Check if 'display_picture', 'bio', or 'location' are not empty
//   return data['display_picture'] != null && data['display_picture'].isNotEmpty &&
//          data['bio'] != null && data['bio'].isNotEmpty &&
//          data['location'] != null && data['location'].isNotEmpty;
// }

  Future<List<UserModel>> fetchChefDocuments() async {
 
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
