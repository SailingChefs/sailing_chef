
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? displayName;
  final String? email;
  final String? userRole;
  String ? userDocId;
   String? uid;
  final String? bio;
  final String? boatName;
  final DateTime? createdTime;
  String ?displayPicture;
  final String? dob;
  final List<String>? followers;
  final List<String>? following;
  final String? location;
  final String? link;
  final String? phoneNumber;
  final List<String>? savedRecipes;
  final String? syJoy;

  UserModel({
    this.syJoy,
     this.displayName,
     this.email,
     this.userRole,
     this.uid,
    this.bio,
    this.boatName,
    this.createdTime,
    this.displayPicture,
    this.userDocId,
    this.dob,
    this.followers,
    this.following,
    this.location,
    this.link,
    this.phoneNumber,
    this.savedRecipes,
  });

  Map<String, dynamic> toMap() {
    return {
      'display_name': displayName,
      'email': email,
      'user_role': userRole,
      'uid': uid,
      'bio': bio,
      'boat_name': boatName,
      'created_time': createdTime,
      'display_picture': displayPicture,
      'dob': dob,
      'followers': followers,
      'following': following,
      'location': location,
      'link': link,
      'phone_number': phoneNumber,
      'saved_recipes': savedRecipes,
      'sy_joy': syJoy
    };
  }

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
      'dob': dob,
      'followers': followers,
      'following': following,
      'location': location,
      'link': link,
      'phone_number': phoneNumber,
      'saved_recipes': savedRecipes,
      'sy_joy': syJoy

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
      dob: data['dob'],
      followers: List<String>.from(data['followers'] ?? []),
      following: List<String>.from(data['following'] ?? []),
      location: data['location'],
      link: data['link'],
      phoneNumber: data['phone_number'],
      savedRecipes: List<String>.from(data['saved_recipes'] ?? []),
      syJoy: data['sy_joy'],
    );
  }
}
