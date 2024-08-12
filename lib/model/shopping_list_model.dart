import 'ingredients_model.dart';
import 'recipe_model.dart';

class ShoppingListModel {
  final List<RecipeModel> selectedRecipees;
  final Map<String, Map<String, dynamic>> shoppingRecipeeIngredient;
  final Map<String, Map<String, dynamic>> showShoppingListview;

  ShoppingListModel({
    required this.selectedRecipees,
    required this.shoppingRecipeeIngredient,
    required this.showShoppingListview,
  });

  // Constructor for empty data
  factory ShoppingListModel.empty() {
    return ShoppingListModel(
      selectedRecipees: [],
      shoppingRecipeeIngredient: {},
      showShoppingListview: {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'selectedRecipees':
          selectedRecipees.map((recipe) => recipe.toMap()).toList(),
      'shoppingRecipeeIngredient': shoppingRecipeeIngredient.map((key, value) {
        return MapEntry(key, {
          'selected_ingredients':
              (value['selected_ingredients'] as List<dynamic>)
                  .map((ingredient) => (ingredient as Ingredient).toJson())
                  .toList(),
          'unselected_ingredients':
              (value['unselected_ingredients'] as List<dynamic>)
                  .map((ingredient) => (ingredient as Ingredient).toJson())
                  .toList(),
          'recipee_name': value['recipee_name'],
        });
      }),
      'showShoppingListview': showShoppingListview.map((key, value) {
        return MapEntry(key, {
          'selected_ingredients':
              (value['selected_ingredients'] as List<dynamic>)
                  .map((ingredient) => (ingredient as Ingredient).toJson())
                  .toList(),
          'unselected_ingredients':
              (value['unselected_ingredients'] as List<dynamic>)
                  .map((ingredient) => (ingredient as Ingredient).toJson())
                  .toList(),
          'recipee_id': value['recipee_id'],
        });
      }),
    };
  }

  factory ShoppingListModel.fromJson(Map<String, dynamic> json) {
    return ShoppingListModel(
      selectedRecipees: (json['selectedRecipees'] as List<dynamic>)
          .map((recipe) => RecipeModel.fromMap(recipe))
          .toList(),
      shoppingRecipeeIngredient: Map<String, Map<String, dynamic>>.from(
              json['shoppingRecipeeIngredient'])
          .map((key, value) {
        return MapEntry(key, {
          'selected_ingredients':
              (value['selected_ingredients'] as List<dynamic>)
                  .map((ingredient) =>
                      Ingredient.fromMap(ingredient as Map<String, dynamic>))
                  .toList(),
          'unselected_ingredients':
              (value['unselected_ingredients'] as List<dynamic>)
                  .map((ingredient) =>
                      Ingredient.fromMap(ingredient as Map<String, dynamic>))
                  .toList(),
          'recipee_name': value['recipee_name'],
        });
      }),
      showShoppingListview:
          Map<String, Map<String, dynamic>>.from(json['showShoppingListview'])
              .map((key, value) {
        return MapEntry(key, {
          'selected_ingredients':
              (value['selected_ingredients'] as List<dynamic>)
                  .map((ingredient) =>
                      Ingredient.fromMap(ingredient as Map<String, dynamic>))
                  .toList(),
          'unselected_ingredients':
              (value['unselected_ingredients'] as List<dynamic>)
                  .map((ingredient) =>
                      Ingredient.fromMap(ingredient as Map<String, dynamic>))
                  .toList(),
          'recipee_id': value['recipee_id'],
        });
      }),
    );
  }

  @override
  String toString() {
    return 'ShoppingListModel(selectedRecipees: $selectedRecipees, shoppingRecipeeIngredient: $shoppingRecipeeIngredient, showShoppingListview: $showShoppingListview)';
  }
}
