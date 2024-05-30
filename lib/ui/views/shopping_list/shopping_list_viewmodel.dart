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
}
