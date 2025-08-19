import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/model/recipe_model.dart';

class SavedRecipeModel {
  String recipeId;

  RecipeModel? recipeModel;
  SavedRecipeModel({
    required this.recipeId,
    this.recipeModel,
  });
  Map<String, dynamic> toMap() {
    return {
      'recipeId': recipeId,
    };
  }

  factory SavedRecipeModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return SavedRecipeModel(
      recipeId: data['recipeId'],
      recipeModel: data['recipeModel'] != null
          ? RecipeModel.fromSnapshot(data['recipeModel'])
          : null,
    );
  }
}
