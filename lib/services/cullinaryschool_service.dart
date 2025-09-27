import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/cullinary_cources.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';

class CullinaryschoolService with ListenableServiceMixin {
  List<UserModel> cullinaryscools = [];
  List<Course> courses = [];
  bool isInitialized = false;

  Future<void> culinaryInit() async {
    if (isInitialized) return;
    cullinaryscools = await _fetchCulinaryDocuments();
    isInitialized = true;
    notifyListeners();
  }

  Future<void> cullinaryCoursesInit(String uid) async {
    courses.clear();
    courses = await getCoursesFromDatabase(userId: uid);
    // Call notifyListeners only once when data is ready
    notifyListeners();
  }

  Future<void> cullinaryCoursesAdd(Course course) async {
    log(course.toString());
    if (courses.any((element) => element.id == course.id)) {
      await _updateCourseToDatabase(course);
      // Remove redundant notifyListeners
    } else {
      await _addCourseToDatabase(course);
      courses.add(course);
      userDetails!.schoolCourses!.add(course.id!);
    }
    // Call notifyListeners only once at the end
    notifyListeners();
  }

  Stream<List<UserModel>> cullinaryInitt() {
    return FirebaseFirestore.instance
        .collection('users')
        .where(
          'user_role',
          isEqualTo: 'culinarySchool',
        )
        .where('uid', isNotEqualTo: firebaseAuth.currentUser?.uid)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map(UserModel.fromSnapshot).toList());
  }

  Future<void> deleteCullinaryCoursesData(
    String courseId,
  ) async {
    try {
      // First update the database
      await firebasestore.collection('users').doc(firebaseAuth.currentUser!.uid).update({
        'school_courses': FieldValue.arrayRemove([courseId])
      });

      // Then update the local data
      await _deleteCourseFromDatabase(userId: userDetails!.uid!, courseId: courseId);
      courses.removeWhere((element) => element.id == courseId);

      // Show toast and notify listeners after all operations are complete
      showToast(message: 'Course removed successfully');
      notifyListeners();
    } catch (e) {
      log('Error deleting course $courseId: $e');
      showToast(message: 'Failed to remove course. Please try again.');
    }
  }

  Future<List<UserModel>> _fetchCulinaryDocuments() async {
    final users = <UserModel>[];

    try {
      final QuerySnapshot querySnapshot = await firebasestore
          .collection('users')
          .where(
            'user_role',
            isEqualTo: 'culinarySchool',
          )
          .where('uid', isNotEqualTo: firebaseAuth.currentUser?.uid)
          .get();

      for (final doc in querySnapshot.docs) {
        final user = UserModel.fromSnapshot(doc);
        if (!userDetails!.blockedAccounts!.contains(user.uid)) {
          users.add(user);
        }
      }
      isInitialized = true;
      return users;
    } catch (error) {
      return users;
    }
  }

  Future<void> _addCourseToDatabase(Course course) async {
    try {
      final DocumentReference courseRef =
          await firebasestore.collection('courses').add(course.toMap());
      course.id = courseRef.id;
      await firebasestore.collection('courses').doc(course.id).update({
        'id': course.id,
      });

      await firebasestore.collection('users').doc(userDetails!.uid).update({
        'school_courses': FieldValue.arrayUnion([course.id]),
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Course>> _updateCourseToDatabase(Course course) async {
    try {
      await firebasestore.collection('courses').doc(course.id).update(course.toMap());
      courses = courses.map((c) => c.id == course.id ? course : c).toList();
      // Remove notifyListeners from here - let the calling method handle UI updates
      return courses;
    } catch (e) {
      log('Error updating course ${course.id}: $e');
      return courses;
    }
  }

  Future<List<Course>> getCoursesFromDatabase({
    required String userId,
  }) async {
    var courses = <Course>[];

    try {
      final querySnapshot = await firebasestore.collection('users').doc(userId).get();

      if (querySnapshot.exists) {
        final courseIds =
            (querySnapshot.data()?['school_courses'] as List?)?.cast<String>() ?? <String>[];

        // Use Future.wait to fetch courses in parallel for better performance
        final futures = courseIds.map((courseId) async {
          try {
            final courseSnapshot = await firebasestore.collection('courses').doc(courseId).get();

            if (courseSnapshot.exists) {
              final courseData = courseSnapshot.data()!;
              return Course.fromMap(courseData);
            }
          } catch (e) {
            log('Error fetching course $courseId: $e');
          }
          return null;
        }).toList();

        final results = await Future.wait(futures);
        courses = results.where((course) => course != null).cast<Course>().toList();
      }
    } catch (e) {
      log('Error fetching courses for user $userId: $e');
    }

    return courses;
  }

  Future<void> _deleteCourseFromDatabase({
    required String userId,
    required String courseId,
  }) async {
    try {
      await firebasestore.collection('courses').doc(courseId).delete();

      await firebasestore.collection('users').doc(userId).update({
        'school_courses': FieldValue.arrayRemove([courseId]),
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
