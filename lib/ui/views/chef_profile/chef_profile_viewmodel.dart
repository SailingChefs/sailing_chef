import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
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
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/imports/core_imports.dart';

class ChefProfileViewModel extends ReactiveViewModel {
  UserModel userDetails;

  ChefProfileViewModel({required this.userDetails});

  final _navigationService = locator<NavigationService>();
  final _serviceConversations = locator<ConversationService>();
  final _cullinarySchoolService = locator<CullinaryschoolService>();
  final _recipeService = locator<RecipeService>();
  final _savedRecipeService = locator<SavedRecipeService>();
  final FollowService _followService = locator<FollowService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  String selectedTab = 'Saved';
  bool isMySelected = false;
  bool isSavedSelected = true;

  List<RecipeModel> chefRecipes = [];

  List<String> get followers => _followService.followers;
  final ScrollController scrollController = ScrollController();

  List<RecipeModel> get savedRecipes => savedRecipesGlobal;
  List<SavedRecipeModel>? userSavedRecipe;
  List<Course> get courses => _cullinarySchoolService.courses;
  bool isFollowing = false;

  @override
  List<ListenableServiceMixin> get listenableServices => [
        _followService,
        _cullinarySchoolService,
        _savedRecipeService,
      ];
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

  chefRecipesList(UserModel user) {
    if (RecipeService.recipes.isEmpty) {
      _recipeService.initialized();
    } else {
      log("chefRecipes ${RecipeService.recipes.length}");
      for (var recipe in RecipeService.recipes) {
        log(recipe.uid);
        log('user.uid ${user.uid!}');
        if (recipe.uid == user.uid!) {
          chefRecipes.add(recipe);
        }
        log("chefRecipes ${chefRecipes.length}");
      }
    }
  }

  void onViewModelReady(UserModel user) async {
    setBusy(true);
    await _followService.init(user.uid!, false);
    if (user.userRole != 'guest') {
      chefRecipesList(user);
      // chefRecipes = await _recipeService.fetchRecipesByUID(user.uid!);
      if (user.userRole == 'culinarySchool') {
        _cullinarySchoolService.cullinaryCoursesInit(user.uid!);
      }
    } else if (user.userRole == 'guest') {
      userSavedRecipe =
          await _savedRecipeService.fetchUserSavedRecipes(user.uid!);
    }

    setBusy(false);
  }

  void showBottomSheet(UserModel user) {
    _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.otherChefProfile, data: user);
  }

  void onFollow(UserModel user) async {
    bool check = await _followService.addFollower(user);

    if (check == true) {
      user.followers!.add(userDetails.uid!);
      isFollowing = true;
      return;
    }

    isFollowing = false;
    user.followers!.remove(userDetails.uid!);
    return;
  }

  void toDishesScreen() {
    scrollController.animateTo(
      scrollController.position.devicePixelRatio * 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void goToFollowerList() {
    _navigationService.navigateTo(Routes.followingListView,
        arguments: FollowingListViewArguments(
            user: userDetails, isfromFollowing: false));
  }

  void goToFollowingList() {
    _navigationService.navigateTo(Routes.followingListView,
        arguments: FollowingListViewArguments(
          
            user: userDetails, isfromFollowing: true));
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

  void toDishDetailsScreen(index) async {
    await _navigationService.navigateToSavedRecipeDetailsView(
        isFromPrivateProfile: false,
        recipeModel: chefRecipes[index],
        randomRecipeList: IndexViewModel.getRandomDishes(
            chefRecipes[index], RecipeService.recipes));

    notifyListeners();
  }

  void showRecipeList() {
    // _navigationService.navigateToRecipeListPageView(
    //   isFromProfileView: true,
    // );
  }

  Future<void> onClickUrl(String url) async {
    EasyLoading.show();
    Uri uri = Uri.parse("https://$url");
    // if (await canLaunchUrlString(url)) {
    //   launchUrlString(url, );
    // }
    await launchUrl(uri);
    EasyLoading.dismiss();
  }
}
