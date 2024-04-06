class Ingredient {
  String name;
  String quantity;
  String unit;

  Ingredient({required this.name, required this.quantity, required this.unit});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
    };
  }

  factory Ingredient.fromSnapshot(Map<String, dynamic> snapshot) {
    return Ingredient(
      name: snapshot['name'],
      quantity: snapshot['quantity'],
      unit: snapshot['unit'],
    );
  }
}