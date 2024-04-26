import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/conversation_service.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/ui/views/following_list/following_list_view.dart';

import '../../../core/imports/core_imports.dart';

class ChefProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _serviceConversations = locator<ConversationService>();
  final _recipeService = locator<RecipeService>();
  String selectedTab = 'Myrecipes';
  bool isMySelected = true;
  bool isSavedSelected = false;
  List<Placemark>? placemarks;
  List<RecipeModel>? chefRecipes;

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
    chefRecipes = await _recipeService.fetchRecipesByUID(user.uid!);
    setBusy(false);
  }

  void goToFollowingList(String name) {
    _navigationService.navigateTo(Routes.followingListView,
        arguments: const FollowingListView());
  }

  getUserLocation(UserModel user) async {
    log(user.displayName.toString());
    placemarks = await placemarkFromCoordinates(
        user.location!['latitude'], user.location!['longitude']);
    log(placemarks.toString());
  }

  Future<void> moveToChatScreen(
    UserModel chef,
  ) async {
    var conversationModel = ConversationModel(
      latestMessage: '',
      users: [
        FirebaseAuth.instance.currentUser!.uid,
        chef.uid!,
      ],
      latestMessageType: 'text',
      latestMessageTime: DateTime.now(),
      lastActive: DateTime.now(),
      uid: "",
    );
    String conversationId = await _serviceConversations
        .createOrUpdateConversation(conversationModel);
    log('conversationId: $conversationId');
    _navigationService.navigateToChatView(
        receiver: chef, conversationId: conversationId);
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

  void toDishDetailsScreen(index) {
    _navigationService.navigateToSavedRecipeDetailsView(
        recipeModel: chefRecipes![index]);
  }

  void showRecipeList() {
    _navigationService.navigateToRecipeListPageView(
      isFromProfileView: true,
    );
  }
}
