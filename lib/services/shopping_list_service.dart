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
    if (checkShoppingListAll(recipe)) {
      for (var element in items) {
        _removeFromShoppingList(element);
      }
    } else {
     for (var item in items) {
      if (shoppingList
              .any((element) => element.ingredientId == item.ingredientId) &&
          item.recipeId == recipe.docId) {
      } else {
        _saveShoppingList(item);
      }
    }
    }
   
  }

  bool checkShoppingListAll(RecipeModel recipeModel) {
    return shoppingList
            .where((element) => element.recipeId == recipeModel.docId)
            .length ==
        recipeModel.ingredients.length;
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
}
