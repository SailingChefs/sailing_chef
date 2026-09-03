import 'dart:developer';

import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/app/app.router.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/instances.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  bool isFirstTime = false;
  bool isDeepLink = false;
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserServices>();
  final IndexViewModel viewmodel = IndexViewModel();

  Future<bool> checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('first_time') ?? true;

    if (isFirstTime) {
      await prefs.setBool('first_time', false);
    }

    return isFirstTime;
  }

  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));

    checkDeepLink();

    checkFirstTime().then((isFirstTime) async {
      if (isFirstTime) {
        _navigationService.replaceWithOnboardingView();
      } else {
        if (firebaseAuth.currentUser == null) {
          _navigationService.replaceWithLoginView();
        } else {
          if (!firebaseAuth.currentUser!.emailVerified) {
            _navigationService.replaceWithLoginView();
          } else {
            userDetails = await _userService.getUserDetails();
            userShoppingList = await _userService.fetchShoppingList();

            selectedRecipees = userShoppingList?.selectedRecipees ?? [];
            shoppingRecipeeIngredient =
                userShoppingList?.shoppingRecipeeIngredient ?? {};
            showShoppingListview = userShoppingList?.showShoppingListview ?? {};

            if (userDetails!.userRole == 'guest') {
              viewmodel.initialised;
              _navigationService.replaceWithBottomBarGuestView();
            } else if (userDetails!.userRole == 'supplier') {
              viewmodel.initialised;
              _navigationService.replaceWithBottomNavBarSupplierView();
            } else {
              viewmodel.initialised;
              _navigationService.replaceWithBottomNavBarView();
            }
          }
        }
      }
    });
    notifyListeners();
  }

  void checkDeepLink() {
    // final data = await FirebaseDynamicLinks.instance.getInitialLink();
    // final deepLink = data?.link;

    // if (deepLink != null) {
    //   isDeepLink = true;
    //   _handleDynamicLinks(deepLink);
    // }

    // FirebaseDynamicLinks.instance.onLink.listen((PendingDynamicLinkData? link) {
    //   isDeepLink = true;
    //   _handleDynamicLinks(link!.link);
    // }).onError((error) {
    //   log('onLink error: $error');
    // });
  }

  RecipeService recipeService = locator<RecipeService>();

  List<RecipeModel>? allRecipes;
  Future<List<RecipeModel>> getRandomDishes(
    String currentRecipe,
  ) async {
    allRecipes = await recipeService.fetchAllPublicRecipes();
    final dishes = List<RecipeModel>.of(allRecipes!);
    dishes.removeWhere((recipe) => recipe.docId == currentRecipe);

    dishes.shuffle();
    log(dishes.length.toString());

    return dishes.length > 5 ? dishes.sublist(0, 5) : dishes;
  }

  Future<void> _handleDynamicLinks(Uri deepLink) async {
    final recipeId = deepLink.queryParameters['recipe'];
    if (recipeId != null) {
      final recipeService = locator<RecipeService>();
      final recipe = await recipeService.fetchRecipeById(recipeId);
      //  getRandomDishes(recipeId);
      if (recipe != null) {
        final navigation = locator<NavigationService>();
        navigation.navigateToSavedRecipeDetailsView(
            recipeModel: recipe,
            isFromPrivateProfile: false,
            randomRecipeList: []);
      }
    }
  }
}
