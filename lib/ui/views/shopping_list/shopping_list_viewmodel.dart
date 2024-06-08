import 'dart:developer';

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/shopping_list.dart';
import 'package:sailing_chefs/services/shopping_list_service.dart';

class ShoppingListViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _shoppingListService = locator<ShoppingListService>();
  List<ShoppingList> get shoppingList => _shoppingListService.shoppingList;

  @override
  List<ListenableServiceMixin> get listenableServices => [_shoppingListService];
  void onViewModelReady() async {
    setBusy(true);
    await _shoppingListService.getShoppingList();
    log('this is done');
    log(shoppingList.toString());
    setBusy(false);
  }

  void back() {
    _navigationService.back();
  }

  void removeRecipe(ShoppingList shoppingList) async {
    await _shoppingListService.addOrRemoveFromShoppingList(shoppingList);
    rebuildUi();
  }

  void addAllItemsToCart(ShoppingList ingredient) async {
    List<ShoppingList> shoppingList = [];
      shoppingList.add(ShoppingList(
          recipeName: ingredient.recipeName,
          ingredientName: ingredient.ingredientName,
          quantity: ingredient.quantity,
          unit: ingredient.unit,
          id: '',
          recipeId: ingredient.recipeId,
          ingredientId: ingredient.id));
    _shoppingListService.addOrRemoveAllFromShopping(shoppingList, ingredient);

    rebuildUi();
  }

  void addOneItemToCart(ShoppingList ingredient) {
    _shoppingListService.addOrRemoveFromShoppingList(ShoppingList(
        recipeName: ingredient.recipeName,
        ingredientName: ingredient.ingredientName,
        quantity: ingredient.quantity,
        unit: ingredient.unit,
        id: '',
        recipeId: ingredient.recipeId,
        ingredientId: ingredient.id));
    rebuildUi();
  }

  bool checkShoppingList(ShoppingList ingredient) {
    if (shoppingList.any((element) => element.ingredientId == ingredient.id)) {
      return true;
    }
    return false;
  }
}
