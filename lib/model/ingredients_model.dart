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
  late final String name;
  late final String quantity;
  late final String unit;
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
    final id = map['id']?.toString() ?? '';
    final name = map['name']?.toString() ?? '';
    final quantity = map['quantity']?.toString() ?? '';
    final unit = map['unit']?.toString() ?? '';

    final dynamic rawServing = map['serving'];
    final int serving;
    if (rawServing is int) {
      serving = rawServing;
    } else if (rawServing is String) {
      serving = int.tryParse(rawServing) ?? 1;
    } else if (rawServing == null) {
      serving = 1;
    } else {
      serving = int.tryParse(rawServing.toString()) ?? 1;
    }

    return Ingredient(
      id: id,
      name: name,
      quantity: quantity,
      unit: unit,
      serving: serving,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ingredient && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
