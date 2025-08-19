import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/ingredients_model.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/shopping_list.dart';
import 'package:sailing_chefs/services/shopping_list_service.dart';
import 'package:sailing_chefs/services/user_services.dart';

class ShoppingListViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final shoppingListService = locator<ShoppingListService>();
  final userService = locator<UserServices>();

  final List<String> selectedRecipees = [];

  List<ShoppingItem> localShoppingList = [];
  List<Ingredient> selectedRecipee = [];
  List<Ingredient> unSelectedRecipee = [];

  List<ShoppingItem> get shoppingList => localShoppingList.toList();

  @override
  List<ListenableServiceMixin> get listenableServices => [shoppingListService];

  void onViewModelReady() {
    setBusy(true);
    // getAllShoppingList();

    // await shoppingListService.getShoppingList();
    // localShoppingList = List.from(shoppingListService.shoppingList);
    setBusy(false);
  }

  Future<void> updateShoppingList() async {
    try {
      await userService.updateShoppingList();
    } catch (e, stackTrace) {
      log('Failed to update shopping list in view model: $e');
      log('StackTrace: $stackTrace');
    }
  }

  void clearShoppingLis() {
    shoppingListService.clearAllShoppingList();
    rebuildUi();
  }

  void addRemoveAllIngredientsToShoppingList(RecipeModel recipee) {
    shoppingListService.addAllItemstoShoppingList(recipee: recipee);
    rebuildUi();
  }

  // ~````````````````````````````

  // getAllShoppingList() {
  //   selectedRecipee = [];
  //   unSelectedRecipee = [];

  //   // Iterate through each recipe in the shopping list
  //   shoppingListService.shoppingRecipeeIngredient
  //       .forEach((recipeeIDKey, recipeeDetaialValue) {
  //     // Extract selected ingredients
  //     final selectedIngredients =
  //         recipeeDetaialValue['selected_ingredients'] ?? [];
  //     selectedRecipee.addAll(selectedIngredients);

  //     // Extract all ingredients for the recipe (you need to have this information in your data)
  //     final unselectedIngredients =
  //         recipeeDetaialValue['unselected_ingredients'] ?? [];

  //     // Find unselected ingredients
  //     // final unselectedIngredients = allIngredients.where((ingredient) {
  //     //   return !selectedIngredients.contains(ingredient);
  //     // }).toList();

  //     unSelectedRecipee.addAll(unselectedIngredients);
  //   });
  // }

  void back() {
    _navigationService.back();
  }

  void removeRecipe(ShoppingItem shoppingList) {
    shoppingList.isRemoved = true;
    notifyListeners();
    shoppingListService.addOrRemoveFromShoppingList(shoppingList);
    rebuildUi();
  }

  void addAllItemsToCart(List<ShoppingItem> ingredients) {
    localShoppingList.addAll(ingredients);
    notifyListeners();
    shoppingListService.addOrRemoveAllFromShoppingList(
        ingredients,
        RecipeModel(
          docId: '',
          title: '',
          ingredients: [],
          methods: [],
          tags: [],
          visibility: '',
          chefNote: '',
          coverImage: [],
          createdTime: Timestamp.now(),
          prepTime: '',
          servingSize: 0,
          status: '',
          uid: '',
          waveForm: [],
        ));
    rebuildUi();
  }

  bool? isDeleted = false;

  void addOneItemToCart(
      // ShoppingItem ingredient
      {required Ingredient ingredient,
      required RecipeModel recipee}) {
    shoppingListService.addNewIngredienttoSHoppingList(
        recipee: recipee, ingredient: ingredient);

    // if (!localShoppingList.contains(ingredient)) {
    //   isDeleted = false;
    //   notifyListeners();
    //   localShoppingList.add(ingredient);
    // }
    // isDeleted = true;
    // notifyListeners();
    // await shoppingListService.addOrRemoveFromShoppingList(ingredient);
    rebuildUi();
  }

  bool checkShoppingList(ShoppingItem ingredient) {
    return localShoppingList.any((item) => item.id == ingredient.id);
  }

  bool checkShoppingListAll(RecipeModel recipeModel) {
    return localShoppingList.any((item) => item.recipeId == recipeModel.docId);
  }
}
