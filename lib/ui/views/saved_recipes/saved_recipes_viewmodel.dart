import 'dart:developer';
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
  final TextEditingController searchFollowingController =
      TextEditingController();

  List<RecipeModel> get savedRecipes => _savedRecipeService.savedRecipes;
  List<RecipeModel>? followingRecipes;

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

  Iterable<RecipeModel> searchRecipes(
      List<RecipeModel> recipes, String query) sync* {
    log('came to search');
    for (var recipe in recipes) {
      if (recipe.title
          .toLowerCase()
          .contains(query.toLowerCase())) {
        // rebuildUi();
        yield recipe;
      }
    }
  }

  void onViewModelReady() async {
    setBusy(true);
    await _savedRecipeService.init();
    followingRecipes = await _recipeService.fetchFollowingRecipesByUID();

    setBusy(false);
  }

  void toAllDishesScreen() {
    _navigationService.navigateToExploreAllRecipesView(
        recipes: RecipeService.recipes);
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
        break;
      case 1:
        selectedTab = 'Following';
        break;

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
      SavedRecipeDetailsView(recipeModel: recipe,
        randomRecipeList: IndexViewModel.getRandomDishes(recipe, RecipeService.recipes)),
     
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
      transitionStyle: Transition.downToUp,
    
     
      
    );
  }
}
