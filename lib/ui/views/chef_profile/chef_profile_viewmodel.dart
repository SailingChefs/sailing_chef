import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/saved_recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/conversation_service.dart';
import 'package:sailing_chefs/services/follow_service.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';
import 'package:sailing_chefs/ui/views/following_list/following_list_view.dart';

import '../../../core/imports/core_imports.dart';

class ChefProfileViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _serviceConversations = locator<ConversationService>();
  final _recipeService = locator<RecipeService>();
  final _savedRecipeService = locator<SavedRecipeService>();
  final FollowService _followService = locator<FollowService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  String selectedTab = 'Myrecipes';
  bool isMySelected = true;
  bool isSavedSelected = false;
  List<Placemark>? placemarks;
  List<RecipeModel>? chefRecipes;
  List<String> get followers => _followService.followers;
  List<SavedRecipeModel> get savedRecipes => _savedRecipeService.savedRecipes;
  bool isFollowing = false;

  @override
  List<ListenableServiceMixin> get listenableServices => [_followService];

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
    await _followService.init(user.uid!, false);
    chefRecipes = await _recipeService.fetchRecipesByUID(user.uid!);
    await _savedRecipeService.init();
    setBusy(false);
  }
   void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.otherChefProfile,
    );

   }

  void onFollow(UserModel user) async {
    bool check = await _followService.addFollower(user);
    if (check) {
      isFollowing = true;
    }
  }

  void goToFollowingList(UserModel user) {
    _navigationService.navigateToFollowingListView(user: user);
  }

  getUserLocation(UserModel user) async {
    log(user.displayName.toString());
    if (user.location == null) {
      return placemarks = null;
    }
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
