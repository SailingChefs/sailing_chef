import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/shopping_list.dart';
import 'package:sailing_chefs/services/shopping_list_service.dart';

class ShoppingListViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _shoppingListService = locator<ShoppingListService>();

  List<ShoppingList> localShoppingList = [];

  List<ShoppingList> get shoppingList => localShoppingList.toList();

  @override
  List<ListenableServiceMixin> get listenableServices => [_shoppingListService];

  void onViewModelReady() async {
    setBusy(true);
    await _shoppingListService.getShoppingList();
    localShoppingList = List.from(_shoppingListService.shoppingList);
    setBusy(false);
  }

  void back() {
    _navigationService.back();
  }

  Future<void> removeRecipe(ShoppingList shoppingList) async {
    shoppingList.isRemoved = true;
    notifyListeners();
    await _shoppingListService.addOrRemoveFromShoppingList(shoppingList);
    rebuildUi();
  }

  Future<void> addAllItemsToCart(List<ShoppingList> ingredients) async {
    localShoppingList.addAll(ingredients);
    notifyListeners();
    await _shoppingListService.addOrRemoveAllFromShoppingList(
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

  void addOneItemToCart(ShoppingList ingredient) async {
    if (!localShoppingList.contains(ingredient)) {
      isDeleted = false;
      notifyListeners();
      localShoppingList.add(ingredient);
    }
    isDeleted = true;
    notifyListeners();
    await _shoppingListService.addOrRemoveFromShoppingList(ingredient);
    rebuildUi();
  }

  bool checkShoppingList(ShoppingList ingredient) {
    return localShoppingList.any((item) => item.id == ingredient.id);
  }

  bool checkShoppingListAll(RecipeModel recipeModel) {
    return localShoppingList.any((item) => item.recipeId == recipeModel.docId);
  }
}
