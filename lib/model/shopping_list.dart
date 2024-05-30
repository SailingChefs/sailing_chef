import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';

class ShoppingList {
  final String ingredientName;
  final String quantity;
  final String unit;
  String id;
  final String ingredientId;
  final String recipeId;

  ShoppingList({
    required this.ingredientName,
    required this.quantity,
    required this.ingredientId,
    required this.unit,
    required this.id,
    required this.recipeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'ingredient_name': ingredientName,
      'quantity': quantity,
      'unit': unit,
      'id': id,
      'ingredient_id': ingredientId,
      'user_id': userDetails!.uid,
      'recipe_id': recipeId,
    };
  }

  factory ShoppingList.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ShoppingList(
      ingredientName: data['ingredient_name'],
      quantity: data['quantity'],
      unit: data['unit'],
      ingredientId: data['ingredient_id'] ?? '',
      id: data['id'] ?? '',
      recipeId: data['recipe_id'],
    );
  }
}
