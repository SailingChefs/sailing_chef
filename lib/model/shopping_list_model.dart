import 'package:sailing_chefs/model/ingredients_model.dart';
import 'package:sailing_chefs/model/recipe_model.dart';

class ShoppingListModel {
  final List<RecipeModel> selectedRecipees;
  final Map<String, Map<String, dynamic>> shoppingRecipeeIngredient;
  final Map<String, Map<String, dynamic>> showShoppingListview;

  const ShoppingListModel({
    required this.selectedRecipees,
    required this.shoppingRecipeeIngredient,
    required this.showShoppingListview,
  });

  // Constructor for empty data
  factory ShoppingListModel.empty() {
    return const ShoppingListModel(
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
          .map((recipe) => RecipeModel.fromMap(recipe as Map<String, dynamic>))
          .toList(),
      shoppingRecipeeIngredient: Map<String, Map<String, dynamic>>.from(
              json['shoppingRecipeeIngredient'] as Map<String, dynamic>)
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
      showShoppingListview: Map<String, Map<String, dynamic>>.from(
              json['showShoppingListview'] as Map<String, dynamic>)
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
