import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/model/cullinary_cources.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/user_services.dart';

import '../ui/common/show_toast.dart';

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

  Future<void> addCourseToDatabase({
    required String userId,
    required String name,
    required String link,
    required String desc,
    required String numOfDays,
  }) async {
    try {
      DocumentReference courseRef =
          await FirebaseFirestore.instance.collection('courses').add({
        'name': name,
        'link': link,
        'description': desc,
        'numOfDays': int.parse(numOfDays),
      });
      String courseId = courseRef.id;

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'school_courses': FieldValue.arrayUnion([courseId]),
      });
    } catch (e) {
      showToast(message: e.toString());
    }
  }



  Future<List<Course>> getCoursesFromDatabase({
    required String userId,
  }) async {
    List<Course> courses = [];

    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();

      if (querySnapshot.exists) {
        List<String> courseIds = querySnapshot.data()?['school_courses'].cast<String>() ?? [];

        for (String courseId in courseIds) {
          DocumentSnapshot<Map<String, dynamic>> courseSnapshot =
              await FirebaseFirestore.instance
                  .collection('courses')
                  .doc(courseId)
                  .get();

          if (courseSnapshot.exists) {
            Map<String, dynamic> courseData = courseSnapshot.data()!;
            Course course = Course.fromMap(courseData);
            courses.add(course);
          }
        }
      }
    } catch (e) {
      log(e.toString());
    }

    return courses;
  }
}
