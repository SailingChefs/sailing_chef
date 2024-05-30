import 'package:uuid/uuid.dart';

class Ingredient {
  String name;
  String? id;
  String quantity;
  String unit;

  Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
    this.id,
  });

  Map<String, dynamic> toMap() {
    const Uuid uuid = Uuid();
    return {
      'name': name.trim(),
      'id': uuid.v4(),
      'quantity': quantity.trim(),
      'unit': unit,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? '',
      id: map['id'],
      unit: map['unit'] ?? '',
    );
  }
}
