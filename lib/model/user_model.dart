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
  // Supplier-specific fields
  final String? businessName;
  final String? businessCategory;
  final String? businessContact;
  final String? businessWebsite;
  final String? businessDescription;
  final GeoPoint? supplierLocation;
  // Chef availability
  bool? isAvailable;

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
    this.businessName,
    this.businessCategory,
    this.businessContact,
    this.businessWebsite,
    this.businessDescription,
    this.supplierLocation,
    this.isAvailable,
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
      'business_name': businessName,
      'business_category': businessCategory,
      'business_contact': businessContact,
      'business_website': businessWebsite,
      'business_description': businessDescription,
      'supplier_location': supplierLocation,
      'is_available': isAvailable ?? false,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      uid: data['uid'],
      email: data['email'],
      userRole: data['user_role'],
      displayName: data['display_name'],
      bio: data['bio'],
      boatName: data['boat_name'],
      createdTime: (data['created_time'] as Timestamp?)?.toDate(),
      displayPicture: data['display_picture'],
      followers: List<String>.from(data['followers'] ?? []),
      following: List<String>.from(data['following'] ?? []),
      link: data['link'],
      savedRecipes: List<String>.from(data['saved_Recipes'] ?? []),
      blockedAccounts: List<String>.from(data['blocked_accounts'] ?? []),
      schoolCourses: List<String>.from(data['school_courses'] ?? []),
      recipes: List<String>.from(data['recipes'] ?? []),
      namedLocation: data['address'],
      businessName: data['business_name'],
      businessCategory: data['business_category'],
      businessContact: data['business_contact'],
      businessWebsite: data['business_website'],
      businessDescription: data['business_description'],
      supplierLocation: data['supplier_location'] as GeoPoint?,
      isAvailable: data['is_available'] as bool? ?? false,
    );
  }
}
