import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/saved_recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/chef_service.dart';
import 'package:sailing_chefs/services/cullinaryschool_service.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';

class IndexViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _chefService = locator<ChefService>();
  final _recipeService = locator<RecipeService>();
  final _savedRecipeService = locator<SavedRecipeService>();
  final _cullinaryService = locator<CullinaryschoolService>();
  List<UserModel> get chefList => ChefService.chefs;
  List<UserModel> get cullinary => _cullinaryService.cullinaryscools;

  List<RecipeModel> get dishes => RecipeService.recipes;
  bool isMySelected = true;
  bool isSavedSelected = false;
  String selectedTab = 'Yacht Chefs';
  List<SavedRecipeModel> get savedRecipes => _savedRecipeService.savedRecipes;
  @override
  // ignore: override_on_non_overriding_member
  List<ListenableServiceMixin> get listenableServices =>
      [_savedRecipeService, _recipeService, _cullinaryService, _chefService];

  get toViewCullinarySchool => null;

  void goToFilterView() {
    _navigationService.navigateTo(Routes.filterView);
  }

  static List<RecipeModel> getRandomDishes(
      RecipeModel currentRecipe, List<RecipeModel> allRecipes) {
    // Create a copy of allRecipes
    List<RecipeModel> dishes = List.from(allRecipes);
    // Remove the current recipe from the list
    dishes.removeWhere((recipe) => recipe.docId == currentRecipe.docId);

    // Shuffle the list
    dishes.shuffle();
    log(dishes.length.toString());

    // Take the first 5 elements if there are more than 5 dishes, otherwise return all dishes
    return dishes.length > 5 ? dishes.sublist(0, 5) : dishes;
  }

  Future<void> getUserLocation() async {
    if (userDetails?.location?['latitude'] == null) {
      return;
    }

    placemarks = await placemarkFromCoordinates(
        userDetails!.location!['latitude'],
        userDetails!.location!['longitude']);
  }

  void onViewModelReady() async {
    setBusy(true);
    await Future.wait([
      _cullinaryService.culinaryInit(),
      _chefService.chefInit(),
      _savedRecipeService.init(),
      _recipeService.initialized(),
      getUserLocation(),
    ]);
    notifyListeners();
    rebuildUi();
    setBusy(false);
  }

  void toAllChefsView() {
    _navigationService.navigateToAllChefsView(
      chefList: chefList,
    );
  }

  void yatchSelected() {
    isMySelected = true;
    isSavedSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void savedSelected() async {
    isSavedSelected = true;

    isMySelected = false;
    notifyListeners();
    rebuildUi();
  }

  void toAllRecipesView() {
    _navigationService.navigateToExploreAllRecipesView(
      recipes: dishes,
    );
  }

  void toChefProfile(UserModel chef) {
    if (chef.uid == FirebaseAuth.instance.currentUser!.uid) {
      _navigationService.navigateToChefProfileView(user: chef);
    } else {
      _navigationService.navigateToChefProfileView(
        user: chef,
      );
    }
  }

  void toDishDetailsScreen(index) {
    _navigationService.navigateToSavedRecipeDetailsView(
      recipeModel: dishes[index],
      randomRecipeList: getRandomDishes(dishes[index], dishes),
    );
  }

  void handleTab(int index) {
    switch (index) {
      case 0:
        selectedTab = 'Yacht Chefs';
        break;
      case 1:
        selectedTab = 'Culinary School';
        break;

      default:
        break;
    }

    rebuildUi();
  }

  void toViewCullinarySchools() {
    _navigationService.navigateToCulineryschoolviewallView();
  }

  void toSearch() {
    _navigationService.navigateToSearchView(
      chefList: chefList,
      recipeModel: dishes,
    );
  }
}
