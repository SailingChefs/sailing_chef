import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/chef_service.dart';
import 'package:sailing_chefs/services/cullinaryschool_service.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_view.dart';

class IndexViewModel extends StreamViewModel<List<UserModel>> {
  final _navigationService = locator<NavigationService>();
  final chefService = locator<ChefService>();
  final recipeService = locator<RecipeService>();
  final _savedRecipeService = locator<SavedRecipeService>();
  final cullinaryService = locator<CullinaryschoolService>();
  List<UserModel> get chefList => chefService.chefs;
  List<UserModel> get cullinary => cullinaryService.cullinaryscools;


  Stream<List<UserModel>> getChefs() {
    return chefService.chefInitt();
  }

  @override
  Stream<List<UserModel>> get stream => getChefs();

    Stream<List<UserModel>> getCullinary() {
    return cullinaryService.cullinaryInitt();
  }

  @override
  Stream<List<UserModel>> get culllinary => getChefs();

  List<RecipeModel> get dishes => RecipeService.recipes;
  bool ischefSelected = true;
  bool isculinarySelected = false;
  String selectedTab = 'Yacht Chefs';
  // List<SavedRecipeModel> get savedRecipes => _savedRecipeService.savedRecipes;

  // @override
  //     bool get disposeViewModel => false;
  @override
  // ignore: override_on_non_overriding_member
  List<ListenableServiceMixin> get listenableServices =>
      [_savedRecipeService, recipeService, chefService];

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

  bool? isInitialised;
  bool showShimmer = false;
  void onViewModelReady() async {
    if (isInitialised == null) {
      // setBusy(true);
      showShimmer = true;
      chefService.chefInitt();
      cullinaryService.cullinaryInitt();
      await Future.wait([
        // _cullinaryService.culinaryInit(),
        
        recipeService.initialized(),
      ]);
     
      isInitialised = true;
      showShimmer = false;
      notifyListeners();
      rebuildUi();

      // setBusy(false);
    } else if (isInitialised == true) {
      return;
    }
  }

  void toAllChefsView() {
    _navigationService.navigateToAllChefsView(
      chefList: chefList,
    );
  }

  void yatchSelected() {
    ischefSelected = true;
    isculinarySelected = false;
    notifyListeners();
    rebuildUi();
  }

  void savedSelected() async {
    isculinarySelected = true;

    ischefSelected = false;
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

  void toDishDetailsScreen(RecipeModel recipe) {
    _navigationService.navigateWithTransition(
      SavedRecipeDetailsView(
          recipeModel: recipe,
          randomRecipeList:
              IndexViewModel.getRandomDishes(recipe, dishes)),
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
      transitionStyle: Transition.downToUp,
    );
    // _navigationService.navigateToSavedRecipeDetailsView(
    //   recipeModel: dishes[index],
    //   randomRecipeList: getRandomDishes(dishes[index], dishes),
    // );
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
