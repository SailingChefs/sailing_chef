import 'dart:developer';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_view.dart';

class SavedRecipesViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _savedRecipeService = locator<SavedRecipeService>();
  final _recipeService = locator<RecipeService>();
  final TextEditingController searchSavedController = TextEditingController();
  final TextEditingController searchFollowingController = TextEditingController();

  List<RecipeModel> get savedRecipes => savedRecipesGlobal;

  List<RecipeModel> followingRecipes = [];

  String selectedTab = 'All';
  bool isAllSelected = true;
  bool isFollowingSelected = false;
  @override
  List<ListenableServiceMixin> get listenableServices => [_savedRecipeService];

  void allSelected() {
    isAllSelected = true;
    isFollowingSelected = false;
    notifyListeners();
    rebuildUi();
  }

  Iterable<RecipeModel> searchRecipes() sync* {
    log('came to search');
    for (final recipe in savedRecipes) {
      if (recipe.title.toLowerCase().contains(searchSavedController.text.toLowerCase())) {
        // rebuildUi();
        yield recipe;
      }
    }
  }

  Iterable<RecipeModel> searchFollowingRecipes() sync* {
    log('came to search');
    for (final recipe in followingRecipes) {
      if (recipe.title.toLowerCase().contains(searchFollowingController.text.toLowerCase())) {
        // rebuildUi();
        yield recipe;
      }
    }
  }

  Future<void> mySavedRecipes() async {
    if (RecipeService.recipes.isEmpty) {
      await _recipeService.initialized();
    }
    for (final recipe in RecipeService.recipes) {
      if (userDetails!.savedRecipes!.any((element) => element == recipe.docId)) {
        savedRecipes.add(recipe);
      }
    }
  }

  Future<void> onViewModelReady() async {
    setBusy(true);
    await Future.wait([
      followingChefRecipe(),
    ]);

    setBusy(false);
  }

  Future<void> followingChefRecipe() async {
    if (RecipeService.recipes.isEmpty) {
      followingRecipes = await _recipeService.fetchFollowingRecipesByUID();
    } else {
      for (final recipe in RecipeService.recipes) {
        if (userDetails!.following!.any((element) => element == recipe.uid)) {
          followingRecipes.add(recipe);
        }
      }
    }
  }

  void toAllDishesScreen() {
    _navigationService.navigateToExploreAllRecipesView(recipes: RecipeService.recipes);
  }

  void followingSelected() {
    isFollowingSelected = true;
    isAllSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void handleTab(int index) {
    switch (index) {
      case 0:
        selectedTab = 'All';
      case 1:
        selectedTab = 'Following';

      default:
        break;
    }

    rebuildUi();
  }

  void goBack() {
    log('tapped');
    _navigationService.back();
  }

  void toDishDetailsScreen(RecipeModel recipe) {
    _navigationService.navigateWithTransition(
      SavedRecipeDetailsView(
        isFromPrivateProfile: false,
        recipeModel: recipe,
        randomRecipeList: IndexViewModel.getRandomDishes(recipe, RecipeService.recipes),
      ),
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
      transitionStyle: Transition.downToUp,
    );
  }

  void toFilterScreen() {
    _navigationService.navigateToFilterView();
  }
}
