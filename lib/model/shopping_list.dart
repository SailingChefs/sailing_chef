import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';

class ShoppingList {
  final String ingredientName;
  final String recipeName;
  final String quantity;
  final String unit;
  String id;
  final String ingredientId;
  final String recipeId;
  bool isSelected;

  ShoppingList({
    required this.recipeName,
    required this.ingredientName,
    required this.quantity,
    required this.ingredientId,
    required this.unit,
    required this.id,
    required this.recipeId,
    this.isSelected = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'ingredient_name': ingredientName,
      'recipe_name': recipeName,
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
      recipeName: data['recipe_name'],
      ingredientName: data['ingredient_name'],
      quantity: data['quantity'],
      unit: data['unit'],
      ingredientId: data['ingredient_id'] ?? '',
      id: data['id'] ?? '',
      recipeId: data['recipe_id'],
    );
  }
}
