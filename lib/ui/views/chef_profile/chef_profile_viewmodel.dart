import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/model/conversation_model.dart';
import 'package:sailing_chefs/model/cullinary_cources.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/model/saved_recipe_model.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/services/conversation_service.dart';
import 'package:sailing_chefs/services/cullinaryschool_service.dart';
import 'package:sailing_chefs/services/follow_service.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/imports/core_imports.dart';

class ChefProfileViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _serviceConversations = locator<ConversationService>();
  final _cullinarySchoolService = locator<CullinaryschoolService>();
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
  List<SavedRecipeModel> ? userSavedRecipe;
  List<Course> get courses => _cullinarySchoolService.courses;
  bool isFollowing = false;

  @override
  List<ListenableServiceMixin> get listenableServices => [_followService];
  List<RecipeModel>? myRecipes;

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
    userSavedRecipe = await _savedRecipeService.fetchUserSavedRecipes(user.uid!);
    _savedRecipeService.init();
    _cullinarySchoolService.cullinaryCoursesInit(user.uid!);
    log(courses.length.toString());
    setBusy(false);
  }

  void showBottomSheet(String uid) {
    _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.otherChefProfile, data: uid);
  }

  void onFollow(UserModel user) async {
    bool check = await _followService.addFollower(user);
    if (check) {
      isFollowing = true;
    }
  }

  void goToFollowingList() {
   showToast(message: 'You cannot see Others following/followers list');
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
 void checkSave(){
  
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

  void toSettings(bool isCurrentUser, String uid) {
    _navigationService.navigateToSettingsView(
        isCurrentUser: isCurrentUser, uid: uid);
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
        recipeModel: chefRecipes![index],
        randomRecipeList:
            IndexViewModel.getRandomDishes(chefRecipes![index], RecipeService.recipes));
  }

  void showRecipeList() {
    _navigationService.navigateToRecipeListPageView(
      isFromProfileView: true,
    );
  }

  Future<void> onClickUrl(String url) async {
    Uri uri = Uri.parse("https://$url");
    // if (await canLaunchUrlString(url)) {
    //   launchUrlString(url, );
    // }
    await launchUrl(uri);
  }
}
