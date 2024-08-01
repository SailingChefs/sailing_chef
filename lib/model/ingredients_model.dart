// class Ingredient {
//   final String id;
//   final String name;
//   final String quantity;
//   final String unit;

//   Ingredient({
//     required this.id,
//     required this.name,
//     required this.quantity,
//     required this.unit,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'quantity': quantity,
//       'unit': unit,
//     };
//   }

//   factory Ingredient.fromMap(Map<String, dynamic> map) {
//     return Ingredient(
//       id: map['id'] ?? '',
//       name: map['name'] ?? '',
//       quantity: map['quantity'] ?? '',
//       unit: map['unit'] ?? '',
//     );
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Ingredient && runtimeType == other.runtimeType && id == other.id;

//   @override
//   int get hashCode => id.hashCode;
// }

class Ingredient {
  final String id;
  final String name;
  final String quantity;
  final String unit;
  final int serving;

  Ingredient({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.serving,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'serving': serving,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      unit: map['unit'],
      serving: map['serving'] ?? 1,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ingredient && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
