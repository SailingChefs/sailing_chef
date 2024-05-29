import 'package:uuid/uuid.dart';

class Ingredient {
  String name;
  String? id;
  String quantity;
  String unit;
  int? totalQuantity;
  bool? isInShoppingList;

  Ingredient(
      {required this.name,
      required this.quantity,
      required this.unit,
      this.id,
      this.isInShoppingList});

  Map<String, dynamic> toMap() {
    const Uuid uuid = Uuid();
    return {
      'name': name,
      'id': uuid.v4(),
      'quantity': quantity,
      'unit': unit,
      'isInShoppingList': isInShoppingList
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? '',
      id: map['id'],
      unit: map['unit'] ?? '',
      isInShoppingList: map['isInShoppingList'],
    );
  }
}
