import 'package:sailing_chefs/core/global_uservariable.dart';

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/saved_recipe_model.dart';
import 'package:sailing_chefs/services/follow_service.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';
import 'package:sailing_chefs/ui/views/following_list/following_list_view.dart';
import 'package:geocoding/geocoding.dart';

class ProfileViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final RecipeService _recipeService = locator<RecipeService>();
  final SavedRecipeService _savedRecipeService = locator<SavedRecipeService>();
  final FollowService _followService = locator<FollowService>();

  String selectedTab = 'Myrecipes';
  bool isMySelected = true;
  bool isSavedSelected = false;
  List<SavedRecipeModel> get savedRecipes => _savedRecipeService.savedRecipes;
  List<String> get followingList => _followService.following;

  List<RecipeModel>? myRecipes;

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_savedRecipeService, _followService];

  // List<SavedRecipeModel> get fetchSavedRecipesList {
  //   return _savedRecipeService.savedRecipes;
  // }

  List<Placemark>? placemarks;
  // A function to handle the selection of my recipe, updating the relevant flags and triggering UI updates.
  void myRecipeSelected() {
    isMySelected = true;
    isSavedSelected = false;
    notifyListeners();
    rebuildUi();
  }

  // A function to set the isSavedSelected flag to true, isMySelected flag to false, notify listeners, and rebuild the UI.
  void savedSelected() {
    isSavedSelected = true;
    isMySelected = false;
    notifyListeners();
    rebuildUi();
  }

  getUserLocation() async {
    if (userDetails?.location?['latitude'] == null) {
      return '';
    }

    placemarks = await placemarkFromCoordinates(
        userDetails!.location!['latitude'],
        userDetails!.location!['longitude']);
  }

  void goTogoToProfileEditView(String name) {
    _navigationService.navigateTo(Routes.followingListView,
        arguments: const FollowingListView());
  }

  // A function that navigates to the settings view.
  void toSettings() {
    _navigationService.navigateToSettingsView();
  }

  // A function that handles the tab based on the given index.
  void handleTab(int index) {
    switch (index) {
      case 0:
        selectedTab = 'Myrecipes';
        break;
      case 1:
        selectedTab = 'Saved';
        break;

      default:
        break;
    }

    rebuildUi();
  }

  void onViewModelReady() async {
    setBusy(true);
    await getUserLocation();
    await _savedRecipeService.init();
    await _followService.init(userDetails!.uid!, false);
    myRecipes = await _recipeService.fetchRecipesByUID(userDetails!.uid!);
    setBusy(false);
  }

  void toDishesScreen() {
    _navigationService.navigateToRecipeListPageView(
      isFromProfileView: true,
    );
  }

  void toDishDetailsScreen(index) {
    _navigationService.navigateToSavedRecipeDetailsView(
      recipeModel: myRecipes![index],
    );
  }
}
