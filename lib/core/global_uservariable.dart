import 'package:geocoding/geocoding.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';

import '../model/shopping_list_model.dart';

UserModel? userDetails;
List<RecipeModel> savedRecipesGlobal = [];
List<Placemark>? placemarks;
ShoppingListModel? userShoppingList;

//
List<RecipeModel> selectedRecipees = <RecipeModel>[];

Map<String, Map<String, dynamic>> shoppingRecipeeIngredient = {};
List<dynamic> recipeeDatails = [];

Map<String, Map<String, dynamic>> showShoppingListview = {};
