// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sailing_chefs/model/comment_model.dart';
// import 'package:sailing_chefs/model/user_model.dart';
// import 'package:sailing_chefs/model/ingredients_model.dart';

// class RecipeModel {
//   String chefNote;
//   List<String> coverImage;
//   final Timestamp createdTime;
//   final List<Ingredient> ingredients;
//   final List<String> methods;
//   String prepTime;
//   int servingSize;
//   final String status;
//   String title;
//   final String uid;
//   final String visibility;
//   String? docId;
//   List<double> waveForm;
//   UserModel? user;
//   // ignore: prefer_typing_uninitialized_variables
//   var rating;
//   List<String>? tags;
//   List<CommentModel>? comment;

//   double? ratingCount;

//   RecipeModel({
//     required this.visibility,
//     required this.chefNote,
//     this.tags,
//     this.rating,
//     this.ratingCount,
//     this.docId,
//     required this.coverImage,
//     required this.createdTime,
//     required this.ingredients,
//     required this.methods,
//     required this.prepTime,
//     required this.servingSize,
//     required this.status,
//     required this.title,
//     required this.uid,
//     required this.waveForm,
//     this.user,
//     this.comment,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'visibility': visibility,
//       'chef_note': chefNote,
//       'cover_image': coverImage,
//       'tags': tags,
//       'created_time': createdTime,
//       'ingredients':
//           ingredients.map((ingredient) => ingredient.toJson()).toList(),
//       'methods': methods,
//       'prep_time': prepTime,
//       'serving_size': servingSize,
//       'status': status,
//       'title': title,
//       'uid': uid,
//       'waveForm': waveForm,
//       'doc_id': docId,
//       'rating': rating,
//       'ratingCount': ratingCount,
//     };
//   }

//   factory RecipeModel.fromSnapshot(DocumentSnapshot snapshot) {
//     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

//     return RecipeModel(
//       visibility: data['visibility'] ?? '',
//       docId: data['doc_id'] ?? '',
//       chefNote: data['chef_note'] ?? '',
//       coverImage: List<String>.from(data['cover_image'] ?? []),
//       createdTime: data['created_time'] ?? Timestamp.now(),
//       ingredients: (data['ingredients'] as List<dynamic>)
//           .map((ingredient) =>
//               Ingredient.fromMap(ingredient as Map<String, dynamic>))
//           .toList(),
//       methods: List<String>.from(data['methods'] ?? []),
//       prepTime: data['prep_time'] ?? Timestamp.now(),
//       servingSize: data['serving_size'] ?? 0,
//       status: data['status'] ?? '',
//       title: data['title'] ?? '',
//       waveForm: List<double>.from(data['waveForm'] ?? []),
//       uid: data['uid'] ?? '',
//       rating: data['rating'] ?? 0.0,
//       ratingCount: data['ratingCount'] ?? 0.0,
//       comment: data['comment'] != null
//           ? (data['comment'] as List<dynamic>)
//               .map((comment) => CommentModel.fromSnapshot(comment))
//               .toList()
//           : null,
//       tags: List<String>.from(data['tags'] ?? []),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'comment_model.dart';
import 'user_model.dart';
import 'ingredients_model.dart';

class RecipeModel {
  String chefNote;
  List<String> coverImage;
  final Timestamp createdTime;
  final List<Ingredient> ingredients;
  final List<String> methods;
  String prepTime;
  int servingSize;
  final String status;
  String title;
  final String uid;
  final String visibility;
  String? docId;
  List<double> waveForm;
  UserModel? user;
  var rating;
  List<String>? tags;
  List<CommentModel>? comment;
  double? ratingCount;

  RecipeModel({
    required this.visibility,
    required this.chefNote,
    this.tags,
    this.rating,
    this.ratingCount,
    this.docId,
    required this.coverImage,
    required this.createdTime,
    required this.ingredients,
    required this.methods,
    required this.prepTime,
    required this.servingSize,
    required this.status,
    required this.title,
    required this.uid,
    required this.waveForm,
    this.user,
    this.comment,
  });

  Map<String, dynamic> toMap() {
    return {
      'visibility': visibility,
      'chef_note': chefNote,
      'cover_image': coverImage,
      'tags': tags,
      'created_time': createdTime,
      'ingredients':
          ingredients.map((ingredient) => ingredient.toJson()).toList(),
      'methods': methods,
      'prep_time': prepTime,
      'serving_size': servingSize,
      'status': status,
      'title': title,
      'uid': uid,
      'waveForm': waveForm,
      'doc_id': docId,
      'rating': rating,
      'ratingCount': ratingCount,
    };
  }

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      visibility: map['visibility'] ?? '',
      docId: map['doc_id'] ?? '',
      chefNote: map['chef_note'] ?? '',
      coverImage: List<String>.from(map['cover_image'] ?? []),
      createdTime: map['created_time'] ?? Timestamp.now(),
      ingredients: (map['ingredients'] as List<dynamic>)
          .map((ingredient) =>
              Ingredient.fromMap(ingredient as Map<String, dynamic>))
          .toList(),
      methods: List<String>.from(map['methods'] ?? []),
      prepTime: map['prep_time'] ?? '',
      servingSize: map['serving_size'] ?? 0,
      status: map['status'] ?? '',
      title: map['title'] ?? '',
      waveForm: List<double>.from(map['waveForm'] ?? []),
      uid: map['uid'] ?? '',
      rating: map['rating'] ?? 0.0,
      ratingCount: map['ratingCount'] ?? 0.0,
      comment: map['comment'] != null
          ? (map['comment'] as List<dynamic>)
              .map((comment) => CommentModel.fromSnapshot(comment))
              .toList()
          : null,
      tags: List<String>.from(map['tags'] ?? []),
    );
  }

  factory RecipeModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return RecipeModel.fromMap(data);
  }
}
