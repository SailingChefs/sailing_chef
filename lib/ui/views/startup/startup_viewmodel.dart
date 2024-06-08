import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('first_time') ?? true;

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
          userDetails = await _userService.getUserDetails();
          if (userDetails!.userRole == 'guest') {
            viewmodel.initialised;
            _navigationService.replaceWithBottomBarGuestView();
          } else {
            viewmodel.initialised;
            _navigationService.replaceWithBottomNavBarView();
          }
        }
      }
    });
  }

  void checkDeepLink() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      isDeepLink = true;
      _handleDynamicLinks(deepLink);
    }

    FirebaseDynamicLinks.instance.onLink.listen((PendingDynamicLinkData? link) {
      isDeepLink = true;
      _handleDynamicLinks(link!.link);
    }).onError((error) {
      log('onLink error: $error');
    });
  }
  RecipeService recipeService = locator<RecipeService>();

  List<RecipeModel>? allRecipes;
  Future<List<RecipeModel>> getRandomDishes(
    String currentRecipe,
  ) async {
    allRecipes = await recipeService.fetchAllRecipes();
    List<RecipeModel> dishes = List.from(allRecipes!);
    dishes.removeWhere((recipe) => recipe.docId == currentRecipe);

    dishes.shuffle();
    log(dishes.length.toString());

    return dishes.length > 5 ? dishes.sublist(0, 5) : dishes;
  }

  void _handleDynamicLinks(Uri deepLink) async {
    final String? recipeId = deepLink.queryParameters['recipe'];
    if (recipeId != null) {
      RecipeService recipeService = locator<RecipeService>();
      RecipeModel? recipe = await recipeService.fetchRecipeById(recipeId);
      //  getRandomDishes(recipeId);
      if (recipe != null) {
        NavigationService navigation = locator<NavigationService>();
        navigation.navigateToSavedRecipeDetailsView(
            recipeModel: recipe,
            isFromPrivateProfile: false,
            randomRecipeList: []);
      }
    }
  }
}
