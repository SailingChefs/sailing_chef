import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/shopping_list.dart';

class ShoppingListService with ListenableServiceMixin {
  final List<ShoppingList> shoppingList = [];
  bool isIntialized = false;

  Future<void> getShoppingList() async {
    // if (isIntialized) return;
    shoppingList.clear();
    shoppingList.addAll(await _fetchAll());
    isIntialized = true;
  }

  Future<List<ShoppingList>> getShoppingLists() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('shopping_list').get();
    List<ShoppingList> shoppingLists = snapshot.docs
        .map((doc) => ShoppingList.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    return shoppingLists;
  }

  Future<List<ShoppingList>> _fetchAll() async {
    try {
      QuerySnapshot querySnapshot = await firebasestore
          .collection('shopping_list')
          .where('user_id', isEqualTo: userDetails!.uid)
          .get();
      List<ShoppingList> list = querySnapshot.docs
          .map((doc) => ShoppingList.fromSnapshot(doc))
          .toList();
      log('list.length.toString():${list.length.toString()}');
      return list;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<void> saveShoppingList(ShoppingList item) async {
    try {
      final DocumentReference docRef =
          FirebaseFirestore.instance.collection('shopping_list').doc();
      item.id = docRef.id;
      await docRef.set(item.toJson());
      shoppingList.add(item);
      log('Saved item to shopping list: ${item.id}');
      notifyListeners();
    } catch (e) {
      log('Failed to save item to shopping list: ${e.toString()}');
    }
  }

  Future<void> addOrRemoveFromShoppingList(ShoppingList item) async {
    EasyLoading.show();
    if (shoppingList
        .any((element) => element.ingredientId == item.ingredientId)) {
      ShoppingList items = shoppingList
          .where((element) => element.ingredientId == item.ingredientId)
          .first;
      _removeFromShoppingList(items);
      notifyListeners();
      EasyLoading.dismiss();
      return;
    } else {
      _saveShoppingList(item);
      notifyListeners();
      EasyLoading.dismiss();
      return;
    }
  }

  Future<void> addOrRemoveAllFromShoppingList(
      List<ShoppingList> items, RecipeModel recipe) async {
    EasyLoading.show();
    if (checkShoppingListAll(recipe)) {
      for (var element in shoppingList) {
        _removeFromShoppingList(element);
      }
      EasyLoading.dismiss();
    } else {
      for (var item in items) {
        if (shoppingList
                .any((element) => element.ingredientId == item.ingredientId) &&
            item.recipeId == recipe.docId) {
        } else {
          _saveShoppingList(item);
        }
        EasyLoading.dismiss();
      }
    }
  }

  Future<void> addOrRemoveAllFromShopping(
      List<ShoppingList> items, ShoppingList recipe) async {
    EasyLoading.show();
    if (checkShoppingList(recipe)) {
      for (var element in shoppingList) {
        _removeFromShoppingList(element);
      }
      EasyLoading.dismiss();
    } else {
      for (var item in items) {
        if (shoppingList
                .any((element) => element.ingredientId == item.ingredientId) &&
            item.recipeId == recipe.recipeId) {
        } else {
          _saveShoppingList(item);
        }
        EasyLoading.dismiss();
      }
    }
  }

  bool checkShoppingListAll(RecipeModel recipeModel) {
    return shoppingList
            .where((element) => element.recipeId == recipeModel.docId)
            .length ==
        recipeModel.ingredients.length;
  }

  bool checkShoppingList(ShoppingList recipeModel) {
    return shoppingList
            .where((element) => element.recipeId == recipeModel.recipeId)
            .length ==
        recipeModel;
  }

  Future<void> _removeFromShoppingList(ShoppingList item) async {
    try {
      log(item.id);
      await firebasestore.collection('shopping_list').doc(item.id).delete();

      log('before : ${shoppingList.length.toString()}');
      shoppingList.removeWhere((element) => element.id == item.id);
      log('after : ${shoppingList.length.toString()}');

      notifyListeners();
      log('removed');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _saveShoppingList(ShoppingList item) async {
    try {
      final DocumentReference docRef =
          await firebasestore.collection('shopping_list').add(item.toJson());

      item.id = docRef.id;
      await docRef.update({'id': item.id});
      log(item.id);
      shoppingList.add(item);
      notifyListeners();

      log('saved shopping list : ${shoppingList.length.toString()}');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<RecipeModel>> getRecipesWithShoppingListIngredients() async {
    try {
      // Get all ingredient IDs from the shopping list
      List<String> ingredientIds =
          shoppingList.map((item) => item.ingredientId).toList();

      // Query the recipes collection where ingredients contain any of the ingredient IDs
      QuerySnapshot querySnapshot = await firebasestore
          .collection('recipes')
          .where('ingredientIds', arrayContainsAny: ingredientIds)
          .get();

      // Map the results to a list of RecipeModel
      List<RecipeModel> recipes = querySnapshot.docs
          .map((doc) => RecipeModel.fromSnapshot(doc))
          .toList();

      return recipes;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
