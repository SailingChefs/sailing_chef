import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/ingredients_model.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/shopping_list.dart';
import 'package:sailing_chefs/services/user_services.dart';

class ShoppingListService with ListenableServiceMixin {
  final userService = locator<UserServices>();
  final List<ShoppingItem> shoppingList = [];
  // final selectedRecipees = <RecipeModel>[];

  // final Map<String, Map<String, dynamic>> shoppingRecipeeIngredient = {};
  // final List<dynamic> recipeeDatails = [];

  // final Map<String, Map<String, dynamic>> showShoppingListview = {};
  // ~
  // ~
  // ~
  // ~

  // fetAllShoppingList() {
  //   for (var mapData in shoppingRecipeeIngredient.keys) {
  //     selectedRecipees.add(shoppingRecipeeIngredient[mapData]?['recipee_name']);
  //     recipeeDatails.add(shoppingRecipeeIngredient[mapData]);
  //   }

  //   for (var index = 0; index < selectedRecipees.length; index++) {
  //     showShoppingListview[selectedRecipees[index]] = recipeeDatails[index];
  //   }
  // }

  void clearAllShoppingList() {
    shoppingList.clear();
    shoppingRecipeeIngredient.clear();
    recipeeDatails.clear();
    showShoppingListview.clear();
    selectedRecipees.clear();
    notifyListeners();
  }

  void addAllItemstoShoppingList({required RecipeModel recipee}) {
    final unSelectedIngredients = <Ingredient>[];
    var selectedIngredients = <Ingredient>[];
    selectedIngredients =
        (shoppingRecipeeIngredient[recipee.docId]?['selected_ingredients'] as List?)
                ?.cast<Ingredient>() ??
            <Ingredient>[];

    if (selectedIngredients.isEmpty) {
      selectedIngredients.addAll(recipee.ingredients);
      if (!selectedRecipees.contains(recipee)) {
        selectedRecipees.add(recipee);
      }
      unSelectedIngredients.clear();
    } else if (selectedIngredients.isNotEmpty &&
        selectedIngredients.length < recipee.ingredients.length) {
      selectedIngredients.clear();
      selectedIngredients.addAll(recipee.ingredients);
      unSelectedIngredients.clear();
    } else {
      unSelectedIngredients.addAll(recipee.ingredients);
      // selectedRecipees.remove(recipee);

      selectedIngredients.clear();
    }

    shoppingRecipeeIngredient[recipee.docId!] = {
      'selected_ingredients': selectedIngredients,
      'unselected_ingredients': unSelectedIngredients,
      'recipee_name': recipee.title,
    };

    showShoppingListview[recipee.title] = {
      'selected_ingredients': selectedIngredients,
      'unselected_ingredients': unSelectedIngredients,
      'recipee_id': recipee.docId,
    };

    notifyListeners();
  }

  void addNewIngredienttoSHoppingList(
      {required RecipeModel recipee, required Ingredient ingredient}) {
    final allIngredients = recipee.ingredients;

    final selectedIngredients =
        shoppingRecipeeIngredient[recipee.docId]?['selected_ingredients'] as List<Ingredient>? ??
            <Ingredient>[];

    if (selectedIngredients.contains(ingredient)) {
      selectedIngredients.removeWhere((element) => element.id == ingredient.id);
    } else {
      selectedIngredients.add(ingredient);
    }

    final unSelectedIngredients = allIngredients.where((ing) {
      return !selectedIngredients.contains(ing);
    }).toList();

    shoppingRecipeeIngredient[recipee.docId!] = {
      'selected_ingredients': selectedIngredients,
      'unselected_ingredients': unSelectedIngredients,
      'recipee_name': recipee.title,
    };

    showShoppingListview[recipee.title] = {
      'selected_ingredients': selectedIngredients,
      'unselected_ingredients': unSelectedIngredients,
      'recipee_id': recipee.docId,
    };

    if (selectedIngredients.isEmpty) {
      // selectedRecipees.remove(recipee);
      log('Slected Ingredient is empty');
    } else if (!selectedRecipees.contains(recipee.title) &&
        selectedIngredients.contains(ingredient)) {
      selectedRecipees.contains(recipee) ? null : selectedRecipees.add(recipee);
    }
    log('shoppingListIngredients : $shoppingRecipeeIngredient');
    notifyListeners();
  }

  // ~````````````````````

  // addAllItemstoShoppingList({required RecipeModel recipee}) {
  //   List<Ingredient> unSelectedIngredients = [];

  //   List<Ingredient> selectedIngredients =
  //       shoppingRecipeeIngredient[recipee.docId]?["selected_ingredients"]
  //               as List<Ingredient>? ??
  //           <Ingredient>[];

  //   if (selectedIngredients.isEmpty) {
  //     selectedIngredients.addAll(recipee.ingredients);
  //     unSelectedIngredients.clear();
  //   } else {
  //     unSelectedIngredients.addAll(recipee.ingredients);
  //     selectedIngredients.clear();
  //   }

  //   shoppingRecipeeIngredient[recipee.docId!] = {
  //     "selected_ingredients": selectedIngredients,
  //     "unselected_ingredients": unSelectedIngredients,
  //     'recipee_name': recipee.title,
  //   };

  //   showShoppingListview[recipee.title] = {
  //     "selected_ingredients": selectedIngredients,
  //     "unselected_ingredients": unSelectedIngredients,
  //     'recipee_id': recipee.docId,
  //   };

  //   notifyListeners();
  // }

  // addNewIngredienttoSHoppingList(
  //     {required RecipeModel recipee, required Ingredient ingredient}) {
  //   final allIngredients = recipee.ingredients;

  //   final selectedIngredients = shoppingRecipeeIngredient[recipee.docId]
  //           ?["selected_ingredients"] as List<Ingredient>? ??
  //       <Ingredient>[];

  //   if (selectedIngredients.contains(ingredient)) {
  //     selectedIngredients.removeWhere((element) => element.id == ingredient.id);
  //   } else {
  //     selectedIngredients.add(ingredient);
  //   }

  //   final unSelectedIngredient = allIngredients.where((ingredient) {
  //     return !selectedIngredients.contains(ingredient);
  //   }).toList();

  //   shoppingRecipeeIngredient[recipee.docId!] = {
  //     "selected_ingredients": selectedIngredients,
  //     "unselected_ingredients": unSelectedIngredient,
  //     'recipee_name': recipee.title,
  //   };

  //   showShoppingListview[recipee.title] = {
  //     "selected_ingredients": selectedIngredients,
  //     "unselected_ingredients": unSelectedIngredient,
  //     'recipee_id': recipee.docId,
  //   };

  //   selectedIngredients.isEmpty
  //       ? selectedRecipees.remove(recipee.title)
  //       : !selectedRecipees.contains(recipee.title) &&
  //               selectedIngredients.contains(ingredient)
  //           ? selectedRecipees.add(recipee.title)
  //           : null;

  //   notifyListeners();
  // }

  bool checkSelectedIngredient({
    required RecipeModel recipee,
    required Ingredient ingredient,
  }) {
    final selectedIngredients =
        showShoppingListview[recipee.title]?['selected_ingredients'] as List<Ingredient>? ?? [];
    return selectedIngredients.contains(ingredient);
  }

  bool checkAllSelectedIngredients({
    required RecipeModel recipee,
  }) {
    return (shoppingRecipeeIngredient[recipee.docId!]?['unselected_ingredients'] as List?)
            ?.isEmpty ??
        false;
  }
  // ~
  // ~
  // ~

  bool isIntialized = false;

  Future<void> getShoppingList() async {
    // if (isIntialized) return;
    shoppingList.clear();
    shoppingList.addAll(await _fetchAll());
    isIntialized = true;
  }

  Future<List<ShoppingItem>> getShoppingLists() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('shopping_list').get();
    final shoppingLists = snapshot.docs
        .map((doc) => ShoppingItem.fromMap(doc.data()! as Map<String, dynamic>))
        .toList();
    return shoppingLists;
  }

  Future<List<ShoppingItem>> _fetchAll() async {
    try {
      final QuerySnapshot querySnapshot = await firebasestore
          .collection('shopping_list')
          .where('user_id', isEqualTo: userDetails!.uid)
          .get();
      final list = querySnapshot.docs.map(ShoppingItem.fromSnapshot).toList();

      return list;
    } catch (e, stackTrace) {
      log('Issue While Fetching shoppingList :  $stackTrace');
      return [];
    }
  }

  Future<void> saveShoppingList(ShoppingItem item) async {
    try {
      final DocumentReference docRef = FirebaseFirestore.instance.collection('shopping_list').doc();
      item.id = docRef.id;
      await docRef.set(item.toJson());
      shoppingList.add(item);

      notifyListeners();
    } catch (e, stackTrace) {
      log('Error while saving shopping list : $stackTrace');
    }
  }

  void addOrRemoveFromShoppingList(ShoppingItem item) {
    EasyLoading.show();
    if (shoppingList.any((element) => element.ingredientId == item.ingredientId)) {
      final items =
          shoppingList.where((element) => element.ingredientId == item.ingredientId).first;
      _removeFromShoppingList(items);
      notifyListeners();
      EasyLoading.dismiss();
    }
    _saveShoppingList(item);
    notifyListeners();
    EasyLoading.dismiss();
  }

  void addOrRemoveAllFromShoppingList(List<ShoppingItem> items, RecipeModel recipe) {
    EasyLoading.show();
    if (checkShoppingListAll(recipe)) {
      for (final element in shoppingList) {
        _removeFromShoppingList(element);
      }
      EasyLoading.dismiss();
    } else {
      for (final item in items) {
        if (shoppingList.any((element) => element.ingredientId == item.ingredientId) &&
            item.recipeId == recipe.docId) {
        } else {
          _saveShoppingList(item);
        }
        EasyLoading.dismiss();
      }
    }
  }

  void addOrRemoveAllFromShopping(List<ShoppingItem> items, ShoppingItem recipe) {
    EasyLoading.show();
    if (checkShoppingList(recipe)) {
      for (final element in shoppingList) {
        _removeFromShoppingList(element);
      }
      EasyLoading.dismiss();
    } else {
      for (final item in items) {
        if (shoppingList.any((element) => element.ingredientId == item.ingredientId) &&
            item.recipeId == recipe.recipeId) {
        } else {
          _saveShoppingList(item);
        }
        EasyLoading.dismiss();
      }
    }
  }

  bool checkShoppingListAll(RecipeModel recipeModel) {
    return shoppingList.where((element) => element.recipeId == recipeModel.docId).length ==
        recipeModel.ingredients.length;
  }

  bool checkShoppingList(ShoppingItem recipeModel) {
    return shoppingList.where((element) => element.recipeId == recipeModel.recipeId).length ==
        recipeModel;
  }

  Future<void> _removeFromShoppingList(ShoppingItem item) async {
    try {
      await firebasestore.collection('shopping_list').doc(item.id).delete();

      shoppingList.removeWhere((element) => element.id == item.id);

      notifyListeners();
    } catch (e, stackTrace) {
      log('Issue While removing :  $stackTrace');
    }
  }

  Future<void> _saveShoppingList(ShoppingItem item) async {
    try {
      final DocumentReference docRef =
          await firebasestore.collection('shopping_list').add(item.toJson());

      item.id = docRef.id;
      //  await docRef.update({'id': item.id});
      docRef.update({'id': item.id});

      shoppingList.add(item);
      notifyListeners();
    } catch (e, stackTrace) {
      log('Issue While Saving  :  $stackTrace');
    }
  }

  Future<List<RecipeModel>> getRecipesWithShoppingListIngredients() async {
    try {
      // Get all ingredient IDs from the shopping list
      final ingredientIds = shoppingList.map((item) => item.ingredientId).toList();

      // Query the recipes collection where ingredients contain any of the ingredient IDs
      final QuerySnapshot querySnapshot = await firebasestore
          .collection('recipes')
          .where('ingredientIds', arrayContainsAny: ingredientIds)
          .get();

      // Map the results to a list of RecipeModel
      final recipes = querySnapshot.docs.map(RecipeModel.fromSnapshot).toList();

      return recipes;
    } catch (e, stackTrace) {
      log('Issue While getRecipesWithShoppingListIngredients : $stackTrace');
      return [];
    }
  }
}
