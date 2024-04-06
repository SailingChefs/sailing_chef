import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:sailing_chefs/model/dish_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/following_list/following_list_view.dart';

import '../../../core/imports/core_imports.dart';

class ChefProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  String selectedTab = 'Myrecipes';
  bool isMySelected = true;
  bool isSavedSelected = false;
  List<Placemark>? placemarks;
  
  List<DishModel> dishes=[
    DishModel(
         dishId: '1', dishName: 'Healthy Taco Salad', dishImagePath: 'assets/images/icons/chef.jpg', dishPreparationTime: '20', dishChefImage:'assets/images/icons/dp.jpg',),
    DishModel(
         dishId: '2', dishName: 'Healthy Sandwich', dishImagePath: 'assets/images/icons/chef.jpg', dishPreparationTime: '30', dishChefImage:'assets/images/icons/dp.jpg',),
  ];

  void myRecipeSelected() {
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

   void onViewModelReady(UserModel user) async {
    setBusy(true);
    await getUserLocation(user);
    setBusy(false);
  }

  void goTogoToProfileEditView(String name) {
    _navigationService.navigateTo(Routes.followingListView,
        arguments: const FollowingListView());
  }

  getUserLocation(UserModel user) async {
    log(user.displayName.toString());
    placemarks =
        await placemarkFromCoordinates(user.location!['latitude'],user.location!['longitude']);
        log(placemarks.toString());
  }

  void moveToChatScreen() {
    _navigationService.navigateToChatView();
  }

  void toSettings() {
    _navigationService.navigateToSettingsView();
  }

  void moveBack() {
    _navigationService.back();
  }

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


  void toDishDetailsScreen() {
    _navigationService.navigateToSavedRecipeDetailsView();
  }

  void showRecipeList() {
    _navigationService.navigateToRecipeListPageView();
  }

}
