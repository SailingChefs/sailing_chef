import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? displayName;
  final String? email;
  String? userRole;
  String? userDocId;
  String? uid;
  final String? bio;
  final String? boatName;
  final DateTime? createdTime;
  String? displayPicture;
  final List<String>? followers;
  final List<String>? following;
  final String? link;
  final List<String>? savedRecipes;
  final List<String>? blockedAccounts;
  final List<String>? schoolCourses;
  final List<String>? recipes;
  final String? namedLocation;
  final bool isAdmin;

  UserModel({
    this.schoolCourses,
    this.displayName,
    this.recipes,
    this.namedLocation,
    this.email,
    this.userRole,
    this.uid,
    this.bio,
    this.boatName,
    this.createdTime,
    this.displayPicture,
    this.userDocId,
    this.followers,
    this.following,
    this.link,
    this.savedRecipes,
    this.blockedAccounts,
    this.isAdmin = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'display_name': displayName,
      'email': email,
      'user_role': userRole,
      'uid': uid,
      'bio': bio,
      'boat_name': boatName,
      'created_time': createdTime,
      'display_picture': displayPicture,
      'followers': followers,
      'following': following,
      'link': link,
      'address': namedLocation,
      'saved_recipes': savedRecipes,
      'blocked_accounts': blockedAccounts,
      'school_courses': schoolCourses,
      'is_admin': isAdmin,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data()! as Map<String, dynamic>;

    return UserModel(
      uid: data['uid'] as String?,
      email: data['email'] as String?,
      userRole: data['user_role'] as String?,
      displayName: data['display_name'] as String?,
      bio: data['bio'] as String?,
      boatName: data['boat_name'] as String?,
      createdTime: (data['created_time'] as Timestamp?)?.toDate(),
      displayPicture: data['display_picture'] as String?,
      followers: List<String>.from(
          (data['followers'] as List<dynamic>?)?.map((e) => e as String) ?? []),
      following: List<String>.from(
          (data['following'] as List<dynamic>?)?.map((e) => e as String) ?? []),
      link: data['link'] as String?,
      savedRecipes: List<String>.from(
          (data['saved_Recipes'] as List<dynamic>?)?.map((e) => e as String) ??
              []),
      blockedAccounts: List<String>.from(
          (data['blocked_accounts'] as List<dynamic>?)
                  ?.map((e) => e as String) ??
              []),
      schoolCourses: List<String>.from(
          (data['school_courses'] as List<dynamic>?)?.map((e) => e as String) ??
              []),
      recipes: List<String>.from(
          (data['recipes'] as List<dynamic>?)?.map((e) => e as String) ?? []),
      namedLocation: data['address'] as String?,
      isAdmin: (data['is_admin'] as bool?) ?? false,
    );
  }
}
