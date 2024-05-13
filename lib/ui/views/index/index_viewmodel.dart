import 'package:firebase_auth/firebase_auth.dart';
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
  List<UserModel> get chefList => _chefService.chefs;
  List<UserModel> get cullinary => _cullinaryService.cullinaryscools;

  List<RecipeModel> get dishes => _recipeService.recipes;
  bool isMySelected = true;
  bool isSavedSelected = false;
  String selectedTab = 'Yacht Chefs';
  List<SavedRecipeModel> get savedRecipes => _savedRecipeService.savedRecipes;

  List<ListenableServiceMixin> get listenableServices =>
      [_savedRecipeService, _recipeService, _cullinaryService, _chefService];

  get toViewCullinarySchool => null;

  void goToFilterView() {
    _navigationService.navigateTo(Routes.filterView);
  }

  void onViewModelReady() async {
    setBusy(true);
    await Future.wait([
      _cullinaryService.culinaryInit(),
      _chefService.chefInit(),
      _savedRecipeService.init(),
      _recipeService.initialized(),
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
}
