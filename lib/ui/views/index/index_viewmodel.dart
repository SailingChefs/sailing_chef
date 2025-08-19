import 'dart:developer';

import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/chef_service.dart';
import 'package:sailing_chefs/services/cullinaryschool_service.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';
import 'package:sailing_chefs/services/shopping_list_service.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_view.dart';

class IndexViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _chefService = locator<ChefService>();
  final shoppingListService = locator<ShoppingListService>();
  final _recipeService = locator<RecipeService>();
  final userService = locator<UserServices>();
  final _savedRecipeService = locator<SavedRecipeService>();
  final _cullinaryService = locator<CullinaryschoolService>();
  List<UserModel> get chefList => _chefService.chefs;
  List<UserModel> get cullinary => _cullinaryService.cullinaryscools;

  List<RecipeModel> get dishes => RecipeService.recipes;
  bool isMySelected = true;
  bool isSavedSelected = false;
  String selectedTab = 'Yacht Chefs';
  List<RecipeModel> get savedRecipes => savedRecipesGlobal;
  @override
  // ignore: override_on_non_overriding_member
  List<ListenableServiceMixin> get listenableServices =>
      [_savedRecipeService, _recipeService, _cullinaryService, _chefService, _savedRecipeService];

  void get toViewCullinarySchool {}
  bool? isInitialised;
  bool showShimmer = false;

  void goToFilterView() {
    _navigationService.navigateTo(Routes.filterView);
  }

  static List<RecipeModel> getRandomDishes(
      RecipeModel currentRecipe, List<RecipeModel> allRecipes) {
    final dishes = List<RecipeModel>.of(allRecipes);
    dishes.removeWhere((recipe) => recipe.docId == currentRecipe.docId);

    dishes.shuffle();
    log(dishes.length.toString());

    return dishes.length > 5 ? dishes.sublist(0, 5) : dishes;
  }

  Future<void> onViewModelReady() async {
    showShimmer = true;

    await Future.wait([
      _cullinaryService.culinaryInit(),
      _chefService.chefInit(),
      _recipeService.initialized(),
    ]);

    showShimmer = false;
    matchAndAssignUsersToDishes();
    notifyListeners();
    rebuildUi();
  }

  Future<void> toAllChefsView() async {
    await _navigationService.navigateToAllChefsView(
      chefList: chefList,
    );
  }

  void yatchSelected() {
    isMySelected = true;
    isSavedSelected = false;
    notifyListeners();
    rebuildUi();
  }

  void savedSelected() {
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

  void matchAndAssignUsersToDishes() {
    final allUsers = <UserModel>[...chefList, ...cullinary];

    for (var i = 0; i < dishes.length; i++) {
      if (dishes[i].user == null) {
        final matchingUser = allUsers.firstWhere(
          (user) => user.uid == dishes[i].uid,
          orElse: () => UserModel(uid: ''),
        );
        if (matchingUser.uid != null) {
          dishes[i].user = matchingUser;
          if (userDetails!.uid == dishes[i].uid) {
            dishes[i].user = userDetails;
          }
        }
      }
    }
  }

  void toChefProfile(UserModel chef) {
    _navigationService.navigateToChefProfileView(user: chef);
  }

  Future<void> toDishDetailsScreen(RecipeModel recipe) async {
    await _navigationService.navigateWithTransition(
      popGesture: true,
      SavedRecipeDetailsView(
          isFromPrivateProfile: false,
          recipeModel: recipe,
          randomRecipeList: IndexViewModel.getRandomDishes(recipe, dishes)),
      curve: Curves.elasticInOut,
      duration: const Duration(),
      transitionStyle: Transition.rightToLeft,
    );

    notifyListeners();
  }

  void handleTab(int index) {
    switch (index) {
      case 0:
        selectedTab = 'Yacht Chefs';
      case 1:
        selectedTab = 'Culinary School';

      default:
        break;
    }

    rebuildUi();
  }

  Future<void> toViewCullinarySchools() async {
    await _navigationService.navigateToCulineryschoolviewallView();
  }

  void toSearch() {
    _navigationService.navigateToSearchView(
      selectedTagsCount: 0,
      chefList: chefList,
      recipeModel: dishes,
    );
  }

  void goToSettings() {
    _navigationService.navigateToSettingsView();
  }

  void callonRefresh() {
    onViewModelReady();
  }

  Future<void> onRefresh() async {
    userDetails = await userService.getUserDetails();
    userShoppingList = await userService.fetchShoppingList();

    selectedRecipees = userShoppingList?.selectedRecipees ?? [];
    shoppingRecipeeIngredient = userShoppingList?.shoppingRecipeeIngredient ?? {};
    showShoppingListview = userShoppingList?.showShoppingListview ?? {};
  }
}
