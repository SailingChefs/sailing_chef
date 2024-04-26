import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/model/recipe_model.dart';

class SavedRecipeModel {
  String recipeId;
  String userId;
  String docId;
  RecipeModel? recipeModel;
  SavedRecipeModel(
      {required this.recipeId,
      required this.userId,
      this.recipeModel,
      required this.docId});
  Map<String, dynamic> toMap() {
    return {'recipeId': recipeId, 'userId': userId, 'docId': docId};
  }

  factory SavedRecipeModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return SavedRecipeModel(
      recipeId: data['recipeId'],
      userId: data['userId'],
      recipeModel: data['recipeModel'] != null
          ? RecipeModel.fromSnapshot(data['recipeModel'])
          : null,
      docId: data['docId'],
    );
  }
}
