import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/chef_service.dart';
import 'package:sailing_chefs/services/cullinaryschool_service.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_view.dart';

class IndexViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _chefService = locator<ChefService>();
  final _recipeService = locator<RecipeService>();
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
  List<ListenableServiceMixin> get listenableServices => [
        _savedRecipeService,
        _recipeService,
        _cullinaryService,
        _chefService,
        _savedRecipeService
      ];

  get toViewCullinarySchool => null;
  bool? isInitialised;
  bool showShimmer = false;

  void goToFilterView() {
    _navigationService.navigateTo(Routes.filterView);
  }

  static List<RecipeModel> getRandomDishes(
      RecipeModel currentRecipe, List<RecipeModel> allRecipes) {
    List<RecipeModel> dishes = List.from(allRecipes);
    dishes.removeWhere((recipe) => recipe.docId == currentRecipe.docId);

    dishes.shuffle();
    log(dishes.length.toString());

    return dishes.length > 5 ? dishes.sublist(0, 5) : dishes;
  }

  void onViewModelReady() async {
    if (isInitialised == null) {
      // setBusy(true);
      showShimmer = true;

      await Future.wait([
        _cullinaryService.culinaryInit(),
        _chefService.chefInit(),
        _recipeService.initialized(),
      ]);

      showShimmer = false;
      isInitialised = true;

      notifyListeners();
      rebuildUi();

      // setBusy(false);
    } else if (isInitialised == true) {
      return;
    }
    matchAndAssignUsersToDishes();
  }

  void toAllChefsView() async{
    await _navigationService.navigateToAllChefsView(
      preventDuplicates: true,
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

  void matchAndAssignUsersToDishes() {
    List<UserModel> allUsers = [...chefList, ...cullinary];

    for (int i = 0; i < dishes.length; i++) {
      if (dishes[i].user == null) {
        UserModel? matchingUser = allUsers.firstWhere(
          (user) => user.uid == dishes[i].uid,
          orElse: () => UserModel(uid: ''),
        );
        if (matchingUser.uid != null) {
          dishes[i].user = matchingUser;
          if (userDetails!.uid == dishes[i].uid) {
            dishes[i].user = userDetails!;
          }
        }
      }
    }
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

  void toDishDetailsScreen(RecipeModel recipe) async {
    await _navigationService.navigateWithTransition(
     popGesture: true,
     preventDuplicates: true,


      SavedRecipeDetailsView(
          isFromPrivateProfile: false,
          recipeModel: recipe,
          randomRecipeList: IndexViewModel.getRandomDishes(recipe, dishes)),
      curve: Curves.elasticInOut,
      duration: const Duration(milliseconds: 00),
      transitionStyle: Transition.rightToLeft,
    );
    notifyListeners();
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

  void toViewCullinarySchools() async{
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
}
