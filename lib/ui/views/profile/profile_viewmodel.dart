
import 'package:sailing_chefs/core/global_uservariable.dart';

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/ui/views/following_list/following_list_view.dart';
import 'package:geocoding/geocoding.dart';

class ProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final RecipeService _recipeService = locator<RecipeService>();
  String selectedTab = 'Myrecipes';
  bool isMySelected = true;
  bool isSavedSelected = false;
  List<RecipeModel>? myRecipes ;
  List<RecipeModel> savedRecipes = [];


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

    placemarks =
        await placemarkFromCoordinates(userDetails!.location!['latitude'], userDetails!.location!['longitude']);

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
   myRecipes = await _recipeService.fetchRecipesByUID(userDetails!.uid!);
    setBusy(false);
  }
  void toDishesScreen(){
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
