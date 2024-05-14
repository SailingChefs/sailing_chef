import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/cullinary_cources.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/user_services.dart';

import '../ui/common/show_toast.dart';

class CullinaryschoolService with ListenableServiceMixin {
  final _userService = locator<UserServices>();
  List<UserModel> cullinaryscools = [];
  List<Course> courses = [];
  bool isInitialized = false;

  Future<void> culinaryInit() async {
    cullinaryscools = await _fetchCulinaryDocuments();
    notifyListeners();
  }

  void cullinaryCoursesInit(String uid) async {
    courses = await getCoursesFromDatabase(userId: uid);
    notifyListeners();
  }

  Future<void> cullinaryCoursesAdd(Course course) async {
    log(course.toString());
    log(courses.toString());
    if (courses.any((element) => element.id == course.id)) {
      await _updateCourseToDatabase(course);
      notifyListeners();
    } else {
      await _addCourseToDatabase(course);
    }

    notifyListeners();
  }

  Future<void> deleteCullinaryCoursesData(
    String courseId,
  ) async {
    try {
      await firebasestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .update({
        'school_courses': FieldValue.arrayRemove([courseId])
      });
      showToast(message: 'Course removed successfully');
      await _deleteCourseFromDatabase(
          userId: userDetails!.uid!, courseId: courseId);
      courses.removeWhere((element) => element.id == courseId);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
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
      return users;
    }
  }

  Future<void> _addCourseToDatabase(Course course) async {
    try {
      DocumentReference courseRef = await FirebaseFirestore.instance
          .collection('courses')
          .add(course.toMap());
      course.id = courseRef.id;
      await FirebaseFirestore.instance
          .collection('courses')
          .doc(course.id)
          .update({
        'id': course.id,
      });
      courses.add(course);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userDetails!.uid)
          .update({
        'school_courses': FieldValue.arrayUnion([course.id]),
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Course>> _updateCourseToDatabase(Course course) async {
    try {
      await FirebaseFirestore.instance
          .collection('courses')
          .doc(course.id)
          .update(course.toMap());
      courses = courses.map((c) => c.id == course.id ? course : c).toList();
      notifyListeners();
      return courses;
    } catch (e) {
      log(e.toString());
      return courses;
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
        List<String> courseIds =
            querySnapshot.data()?['school_courses'].cast<String>() ?? [];

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

  Future<void> _deleteCourseFromDatabase({
    required String userId,
    required String courseId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('courses')
          .doc(courseId)
          .delete();

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'school_courses': FieldValue.arrayRemove([courseId]),
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
