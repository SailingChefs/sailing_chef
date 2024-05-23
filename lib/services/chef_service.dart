import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/user_services.dart';

class ChefService with ListenableServiceMixin {
  final _userService = locator<UserServices>();
  static List<UserModel> chefs = [];
  bool isInitialized = false;

  Future<void> chefInit() async {
    if(isInitialized) return;
    chefs = await fetchChefDocuments();
    isInitialized = true;
    notifyListeners();
  }

  Future<List<UserModel>> fetchChefDocuments() async {
    List<UserModel> users = [];

    try {
      QuerySnapshot querySnapshot = await firebasestore
          .collection('users')
          .where(
            'user_role',
            isEqualTo: 'chef',
          )
          .where('uid', isNotEqualTo: firebaseAuth.currentUser?.uid)
          // .orderBy('created_at', descending: true)
          .get();
      for (var doc in querySnapshot.docs) {
        // UserModel? currUser = await _userService
        //     .fetchUserByUID(firebaseAuth.currentUser!.uid);
        UserModel user = UserModel.fromSnapshot(doc);

        // int recipeCount = await FirebaseFirestore.instance
        //     .collection('recipes')
        //     .where('uid', isEqualTo: user.uid)
        //     .get()
        //     .then((value) => value.size);

        // user.recipeCount = recipeCount;

        if (!userDetails!.blockedAccounts!.contains(user.uid)) {
          users.add(user);
        }
      }

      // // return users;
      // for (var doc in querySnapshot.docs) {
      //   UserModel? currUser = await _userService
      //       .fetchUserByUID(FirebaseAuth.instance.currentUser!.uid);
      //   UserModel user = UserModel.fromSnapshot(doc);
      //   if (!currUser.blockedAccounts!.contains(user.uid)) {
      //     users.add(user);
      //   }
      // }

      return users;
    } catch (error) {
      // Handle any errors

      return users; // Return an empty list in case of error
    }
  }

  Future<List<UserModel>> fetchChefDishesDocuments(UserModel user) async {
    List<UserModel> users = [];

    try {
      QuerySnapshot querySnapshot = await firebasestore
          .collection('recipes')
          .where(
            'uid',
            isEqualTo: user.uid,
          )
          .where('uid', isNotEqualTo: firebaseAuth.currentUser?.uid)
          .get();

      for (var doc in querySnapshot.docs) {
        UserModel? currUser = await _userService
            .fetchUserByUID(firebaseAuth.currentUser!.uid);
        user = UserModel.fromSnapshot(doc);
        if (!currUser.blockedAccounts!.contains(user.uid)) {
          users.add(user);
        }
      }

      return users;
    } catch (error) {
      return users;
    }
  }
}
