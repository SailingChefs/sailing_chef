
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/model/dish_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/conversation_service.dart';
import 'package:sailing_chefs/ui/views/following_list/following_list_view.dart';

import '../../../core/imports/core_imports.dart';

class ChefProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _serviceConversations = locator<ConversationService>();
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

  Future<void> moveToChatScreen(UserModel chef,) async {
    var conversationModel = ConversationModel(
      isOnline: true,
      name: chef.displayName!,
      imageTitle: [
        chef.displayPicture!,
        userDetails!.displayPicture!,
      ],
      latestMessage: '',
      users: [
        chef.uid!,
        FirebaseAuth.instance.currentUser!.uid, 
      ],
      latestMessageType: 'text',
      latestMessageTime: DateFormat.jm().format(DateTime.now()),
      lastActive: DateFormat.jm().format(DateTime.now()),
      uid: "blahblah"
    );
    String conversationId = await _serviceConversations.createConversation(conversationModel);
    _navigationService.navigateToChatView(user:chef, conversationId:conversationId);
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
