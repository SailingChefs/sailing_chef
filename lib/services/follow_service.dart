import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class FollowService with ListenableServiceMixin {
  final UserServices _userServices = UserServices();
  List<String> followers = [];
  List<String> following = [];

  void addFollowerFromDummy(UserModel user, String userId) {
    log('Ädding follower to firebase');
    // await
    firebasestore.collection('users').doc(user.uid).update({
      'followers': FieldValue.arrayUnion([userId]),
    });
    // await
    firebasestore.collection('users').doc(userId).update({
      'following': FieldValue.arrayUnion([user.uid]),
    });
  }

  void removeFollowerFromDummy(UserModel user, String userId) {
    log('Removing follower From firebase');

    // await
    firebasestore.collection('users').doc(user.uid).update({
      'followers': FieldValue.arrayRemove([firebaseAuth.currentUser!.uid]),
    });
    // await
    firebasestore.collection('users').doc(firebaseAuth.currentUser!.uid).update({
      'following': FieldValue.arrayRemove([user.uid]),
    });
  }

  Future<void> init(String uid, bool fetch) async {
    if (uid.isEmpty) {
      log('Error: uid is empty in init method');
      return;
    }

    followers = await _getFollowersForUser(uid);
    following = await _getFollowingForUser(uid);

    if (fetch) {
      usersFollowers.clear();
      usersFollowing.clear();
      await _getFollowUserDetails();
      await _getFollowingUserDetails();
    }
    notifyListeners();
  }

  List<UserModel> usersFollowers = [];
  List<UserModel> usersFollowing = [];

  Future<void> _getFollowUserDetails() async {
    for (final follower in followers) {
      usersFollowers.add(await _userServices.fetchUserByUID(follower));
    }
    log('followerslength: ${usersFollowers.length}');
  }

  Future<void> _getFollowingUserDetails() async {
    for (final following in following) {
      usersFollowing.add(await _userServices.fetchUserByUID(following));
    }

    notifyListeners();
  }

  Future<bool> _addFollower(UserModel user, String userId) async {
    try {
      EasyLoading.show();
      await firebasestore.collection('users').doc(user.uid).update({
        'followers': FieldValue.arrayUnion([userId]),
      });
      await firebasestore.collection('users').doc(userId).update({
        'following': FieldValue.arrayUnion([user.uid]),
      });
      userDetails = await _userServices.getUserDetails();
      followers.add(userId);
      following.add(user.uid!);
      notifyListeners();
      EasyLoading.dismiss();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<List<String>> _getFollowersForUser(String uid) async {
    if (uid.isEmpty) {
      log('Error: uid is empty in _getFollowersForUser');
      return [];
    }

    try {
      final docSnapshot = await firebasestore.collection('users').doc(uid).get();
      if (docSnapshot.exists && docSnapshot.data() != null) {
        final data = docSnapshot.data()!;
        if (data.containsKey('followers') && data['followers'] != null) {
          return List<String>.from(data['followers']);
        }
      }
      return [];
    } catch (e) {
      log('Error in _getFollowersForUser: $e');
      return [];
    }
  }

  Future<List<String>> _getFollowingForUser(String uid) async {
    if (uid.isEmpty) {
      log('Error: uid is empty in _getFollowingForUser');
      return [];
    }

    try {
      final docSnapshot = await firebasestore.collection('users').doc(uid).get();
      if (docSnapshot.exists && docSnapshot.data() != null) {
        final data = docSnapshot.data()!;
        if (data.containsKey('following') && data['following'] != null) {
          return List<String>.from(data['following']);
        }
      }
      return [];
    } catch (e) {
      log('Error in _getFollowingForUser: $e');
      return [];
    }
  }

  bool addFollower(UserModel user) {
    try {
      EasyLoading.show(); // Show loading indicator

      if (followers.contains(firebaseAuth.currentUser!.uid)) {
        log('true');
        _removeFollower(user);
        notifyListeners();

        EasyLoading.dismiss();
        return false;
      }
      _addFollower(user, firebaseAuth.currentUser!.uid);
      notifyListeners();

      EasyLoading.dismiss();
      return true;
    } catch (error) {
      EasyLoading.dismiss(); // Dismiss loading indicator
      showToast(message: 'Error saving recipe: $error'); // Show error message
      return false;
    }
  }

  Future<void> _removeFollower(UserModel user) async {
    try {
      await firebasestore.collection('users').doc(user.uid).update({
        'followers': FieldValue.arrayRemove([firebaseAuth.currentUser!.uid]),
      });
      await firebasestore.collection('users').doc(firebaseAuth.currentUser!.uid).update({
        'following': FieldValue.arrayRemove([user.uid]),
      });
      userDetails = await _userServices.getUserDetails();
      followers.removeWhere((element) => element == firebaseAuth.currentUser!.uid);
      log('deleted');
      following.removeWhere((element) => element == firebaseAuth.currentUser!.uid);
      log('removed');
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteFollower(UserModel user) async {
    try {
      await firebasestore.collection('users').doc(firebaseAuth.currentUser!.uid).update({
        'followers': FieldValue.arrayRemove([user.uid]),
      });
      await firebasestore.collection('users').doc(user.uid).update({
        'following': FieldValue.arrayRemove([firebaseAuth.currentUser!.uid]),
      });
      // followers.removeWhere((element) => element == user.uid);
      log('deleted');
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> removeFollowing(UserModel user) async {
    try {
      EasyLoading.show();
      await firebasestore.collection('users').doc(firebaseAuth.currentUser!.uid).update({
        'following': FieldValue.arrayRemove([user.uid]),
      });
      await firebasestore.collection('users').doc(user.uid).update({
        'followers': FieldValue.arrayRemove([firebaseAuth.currentUser!.uid]),
      });
      userDetails!.following!.removeWhere((element) => element == user.uid);
      if (user.userRole == 'chef') {
        user.followers!.remove(userDetails!.uid);
      } else if (user.userRole == 'culinary') {
        user.followers!.remove(userDetails!.uid);
      }
      EasyLoading.dismiss();
      notifyListeners();
    } catch (e) {
      log(e.toString());
      notifyListeners();
    }
  }
}
