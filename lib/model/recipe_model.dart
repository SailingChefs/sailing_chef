import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/widgets/ingredients_class.dart';

class RecipeModel {
  final String chefNote;
  List<String> coverImage;
  final Timestamp createdTime;
  final List<Ingredient> ingredients;
  final List<String> methods;
  final String prepTime;
  final int servingSize;
  final String status;
  final String title;
  final String uid;
  final String visibility;
  final String docId;
  List<double> waveForm;
  UserModel? user;

  RecipeModel({
    required this.visibility,
    required this.chefNote,
    required this.docId,
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
  });

  Map<String, dynamic> toMap() {
    return {
      'visibility': visibility,
      'chef_note': chefNote,
      'cover_image': coverImage,
      'created_time': createdTime,
      'ingredients':
          ingredients.map((ingredient) => ingredient.toMap()).toList(),
      'methods': methods,
      'prep_time': prepTime,
      'serving_size': servingSize,
      'status': status,
      'title': title,
      'uid': uid,
      'waveForm': waveForm,
      'doc_id': docId,
    };
  }

  factory RecipeModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return RecipeModel(
      visibility: data['visibility'] ?? '',
      docId: data['doc_id'] ?? '',
      chefNote: data['chef_note'] ?? '',
      coverImage: List<String>.from(data['cover_image'] ?? []),
      createdTime: data['created_time'] ?? Timestamp.now(),
      ingredients: (data['ingredients'] as List<dynamic>)
          .map((ingredient) =>
              Ingredient.fromMap(ingredient as Map<String, dynamic>))
          .toList(),
      methods: List<String>.from(data['methods'] ?? []),
      prepTime: data['prep_time'] ?? Timestamp.now(),
      servingSize: data['serving_size'] ?? 0,
      status: data['status'] ?? '',
      title: data['title'] ?? '',
      waveForm: List<double>.from(data['waveForm'] ?? []),
      uid: data['uid'] ?? '',
    );
  }
}
