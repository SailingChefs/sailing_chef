// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sailing_chefs/core/global_uservariable.dart';

// class ShoppingList {

//   final String ingredientName;
//   final String recipeName;
//   final String quantity;
//   final String unit;
//   String id;
//   final String ingredientId;
//   final String recipeId;
//   bool isSelected;
//   bool isRemoved; // Add this property

//   ShoppingList({
//     required this.recipeName,
//     required this.ingredientName,
//     required this.quantity,
//     required this.ingredientId,
//     required this.unit,
//     required this.id,
//     required this.recipeId,
//     this.isSelected = false,
//     this.isRemoved = false, // Initialize it to false
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'ingredient_name': ingredientName,
//       'recipe_name': recipeName,
//       'quantity': quantity,
//       'unit': unit,
//       'id': id,
//       'ingredient_id': ingredientId,
//       'user_id': userDetails!.uid,
//       'recipe_id': recipeId,
//       'is_removed': isRemoved, // Add this to the JSON
//     };
//   }

//   factory ShoppingList.fromSnapshot(DocumentSnapshot snapshot) {
//     final data = snapshot.data() as Map<String, dynamic>;
//     return ShoppingList(
//       recipeName: data['recipe_name'],
//       ingredientName: data['ingredient_name'],
//       quantity: data['quantity'],
//       unit: data['unit'],
//       ingredientId: data['ingredient_id'] ?? '',
//       id: data['id'] ?? '',
//       recipeId: data['recipe_id'],
//       isRemoved:
//           data['is_removed'] ?? false, // Initialize it to false if not present
//     );
//   }

//   factory ShoppingList.fromMap(Map<String, dynamic> map) {
//     return ShoppingList(
//       recipeName: map['recipe_name'] ?? '',
//       ingredientName: map['ingredient_name'] ?? '',
//       quantity: map['quantity'] ?? '',
//       unit: map['unit'] ?? '',
//       ingredientId: map['ingredient_id'] ?? '',
//       id: map['id'] ?? '',
//       recipeId: map['recipe_id'] ?? '',
//       isRemoved:
//           map['is_removed'] ?? false, // Initialize it to false if not present
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/model/ingredients_model.dart';

class ShoppingItem {
  final String ingredientName;
  final String recipeName;
  final String quantity;
  final String unit;
  String id;
  final String ingredientId;
  final String recipeId;
  bool isSelected;
  bool isRemoved;
  List<Ingredient> ingredients;

  ShoppingItem({
    required this.recipeName,
    required this.ingredientName,
    required this.quantity,
    required this.ingredientId,
    required this.unit,
    required this.id,
    required this.recipeId,
    this.isSelected = false,
    this.isRemoved = false,
    this.ingredients = const [], // Initialize as an empty list by default
  });

  Map<String, dynamic> toJson() {
    return {
      'ingredient_name': ingredientName,
      'recipe_name': recipeName,
      'quantity': quantity,
      'unit': unit,
      'id': id,
      'ingredient_id': ingredientId,
      'recipe_id': recipeId,
      'is_removed': isRemoved,
      'ingredients': ingredients.map((ingredient) => ingredient.toJson()).toList(),
    };
  }

  factory ShoppingItem.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data()! as Map<String, dynamic>;
    return ShoppingItem(
      recipeName: data['recipe_name'] as String,
      ingredientName: data['ingredient_name'] as String,
      quantity: data['quantity'] as String,
      unit: data['unit'] as String,
      ingredientId: (data['ingredient_id'] as String?) ?? '',
      id: (data['id'] as String?) ?? '',
      recipeId: data['recipe_id'] as String,
      isRemoved: (data['is_removed'] as bool?) ?? false,
      ingredients: (data['ingredients'] as List<dynamic>? ?? [])
          .map((ingredient) => Ingredient.fromMap(ingredient as Map<String, dynamic>))
          .toList(),
    );
  }

  factory ShoppingItem.fromMap(Map<String, dynamic> map) {
    return ShoppingItem(
      recipeName: (map['recipe_name'] as String?) ?? '',
      ingredientName: (map['ingredient_name'] as String?) ?? '',
      quantity: (map['quantity'] as String?) ?? '',
      unit: (map['unit'] as String?) ?? '',
      ingredientId: (map['ingredient_id'] as String?) ?? '',
      id: (map['id'] as String?) ?? '',
      recipeId: (map['recipe_id'] as String?) ?? '',
      isRemoved: (map['is_removed'] as bool?) ?? false,
      ingredients: (map['ingredients'] as List<dynamic>? ?? [])
          .map((ingredient) => Ingredient.fromMap(ingredient as Map<String, dynamic>))
          .toList(),
    );
  }
}
