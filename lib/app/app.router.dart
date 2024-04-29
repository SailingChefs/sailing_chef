// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i29;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as _i34;
import 'package:sailing_chefs/core/imports/core_imports.dart' as _i31;
import 'package:sailing_chefs/model/recipe_model.dart' as _i33;
import 'package:sailing_chefs/model/user_model.dart' as _i30;
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/widgets/ingredients_class.dart'
    as _i32;
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_view.dart' as _i14;
import 'package:sailing_chefs/ui/views/all_chefs/all_chefs_view.dart' as _i26;
import 'package:sailing_chefs/ui/views/blocked_accounts/blocked_accounts_view.dart'
    as _i28;
import 'package:sailing_chefs/ui/views/bottom_bar_guest/bottom_bar_guest_view.dart'
    as _i20;
import 'package:sailing_chefs/ui/views/bottom_nav_bar/bottom_nav_bar_view.dart'
    as _i7;
import 'package:sailing_chefs/ui/views/chat_list/chat_list_view.dart' as _i23;
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_view.dart'
    as _i22;
import 'package:sailing_chefs/ui/views/comingsoon/comingsoon_view.dart' as _i15;
import 'package:sailing_chefs/ui/views/edit_profile/edit_profile_view.dart'
    as _i24;
import 'package:sailing_chefs/ui/views/filter/filter_view.dart' as _i12;
import 'package:sailing_chefs/ui/views/following_list/following_list_view.dart'
    as _i18;
import 'package:sailing_chefs/ui/views/forget_password/forget_password_view.dart'
    as _i27;
import 'package:sailing_chefs/ui/views/index/index_view.dart' as _i13;
import 'package:sailing_chefs/ui/views/login/login_view.dart' as _i5;
import 'package:sailing_chefs/ui/views/Messages/chat_view.dart' as _i9;
import 'package:sailing_chefs/ui/views/onboarding/onboarding_view.dart' as _i3;
import 'package:sailing_chefs/ui/views/pin_drop_map/pin_drop_map_view.dart'
    as _i17;
import 'package:sailing_chefs/ui/views/profile/profile_view.dart' as _i10;
import 'package:sailing_chefs/ui/views/recipe_list_page/recipe_list_page_view.dart'
    as _i16;
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_view.dart'
    as _i19;
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_view.dart'
    as _i21;
import 'package:sailing_chefs/ui/views/saved_recipes/saved_recipes_view.dart'
    as _i8;
import 'package:sailing_chefs/ui/views/settings/settings_view.dart' as _i11;
import 'package:sailing_chefs/ui/views/sign_up/sign_up_view.dart' as _i4;
import 'package:sailing_chefs/ui/views/startup/startup_view.dart' as _i2;
import 'package:sailing_chefs/ui/views/user_details/user_details_view.dart'
    as _i6;
import 'package:sailing_chefs/ui/views/video_player/video_player_view.dart'
    as _i25;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i35;

class Routes {
  static const startupView = '/startup-view';

  static const onboardingView = '/onboarding-view';

  static const signUpView = '/sign-up-view';

  static const loginView = '/login-view';

  static const userDetailsView = '/user-details-view';

  static const bottomNavBarView = '/bottom-nav-bar-view';

  static const savedRecipesView = '/saved-recipes-view';

  static const chatView = '/chat-view';

  static const profileView = '/profile-view';

  static const settingsView = '/settings-view';

  static const filterView = '/filter-view';

  static const indexView = '/index-view';

  static const addRecipeView = '/add-recipe-view';

  static const comingsoonView = '/comingsoon-view';

  static const recipeListPageView = '/recipe-list-page-view';

  static const pinDropMapView = '/pin-drop-map-view';

  static const followingListView = '/following-list-view';

  static const recipeViewView = '/recipe-view-view';

  static const bottomBarGuestView = '/bottom-bar-guest-view';

  static const savedRecipeDetailsView = '/saved-recipe-details-view';

  static const chefProfileView = '/chef-profile-view';

  static const chatListView = '/chat-list-view';

  static const editProfileView = '/edit-profile-view';

  static const videoPlayerView = '/video-player-view';

  static const allChefsView = '/all-chefs-view';

  static const forgetPasswordView = '/forget-password-view';

  static const blockedAccountsView = '/blocked-accounts-view';

  static const all = <String>{
    startupView,
    onboardingView,
    signUpView,
    loginView,
    userDetailsView,
    bottomNavBarView,
    savedRecipesView,
    chatView,
    profileView,
    settingsView,
    filterView,
    indexView,
    addRecipeView,
    comingsoonView,
    recipeListPageView,
    pinDropMapView,
    followingListView,
    recipeViewView,
    bottomBarGuestView,
    savedRecipeDetailsView,
    chefProfileView,
    chatListView,
    editProfileView,
    videoPlayerView,
    allChefsView,
    forgetPasswordView,
    blockedAccountsView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.startupView,
      page: _i2.StartupView,
    ),
    _i1.RouteDef(
      Routes.onboardingView,
      page: _i3.OnboardingView,
    ),
    _i1.RouteDef(
      Routes.signUpView,
      page: _i4.SignUpView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i5.LoginView,
    ),
    _i1.RouteDef(
      Routes.userDetailsView,
      page: _i6.UserDetailsView,
    ),
    _i1.RouteDef(
      Routes.bottomNavBarView,
      page: _i7.BottomNavBarView,
    ),
    _i1.RouteDef(
      Routes.savedRecipesView,
      page: _i8.SavedRecipesView,
    ),
    _i1.RouteDef(
      Routes.chatView,
      page: _i9.ChatView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i10.ProfileView,
    ),
    _i1.RouteDef(
      Routes.settingsView,
      page: _i11.SettingsView,
    ),
    _i1.RouteDef(
      Routes.filterView,
      page: _i12.FilterView,
    ),
    _i1.RouteDef(
      Routes.indexView,
      page: _i13.IndexView,
    ),
    _i1.RouteDef(
      Routes.addRecipeView,
      page: _i14.AddRecipeView,
    ),
    _i1.RouteDef(
      Routes.comingsoonView,
      page: _i15.ComingsoonView,
    ),
    _i1.RouteDef(
      Routes.recipeListPageView,
      page: _i16.RecipeListPageView,
    ),
    _i1.RouteDef(
      Routes.pinDropMapView,
      page: _i17.PinDropMapView,
    ),
    _i1.RouteDef(
      Routes.followingListView,
      page: _i18.FollowingListView,
    ),
    _i1.RouteDef(
      Routes.recipeViewView,
      page: _i19.RecipeViewView,
    ),
    _i1.RouteDef(
      Routes.bottomBarGuestView,
      page: _i20.BottomBarGuestView,
    ),
    _i1.RouteDef(
      Routes.savedRecipeDetailsView,
      page: _i21.SavedRecipeDetailsView,
    ),
    _i1.RouteDef(
      Routes.chefProfileView,
      page: _i22.ChefProfileView,
    ),
    _i1.RouteDef(
      Routes.chatListView,
      page: _i23.ChatListView,
    ),
    _i1.RouteDef(
      Routes.editProfileView,
      page: _i24.EditProfileView,
    ),
    _i1.RouteDef(
      Routes.videoPlayerView,
      page: _i25.VideoPlayerView,
    ),
    _i1.RouteDef(
      Routes.allChefsView,
      page: _i26.AllChefsView,
    ),
    _i1.RouteDef(
      Routes.forgetPasswordView,
      page: _i27.ForgetPasswordView,
    ),
    _i1.RouteDef(
      Routes.blockedAccountsView,
      page: _i28.BlockedAccountsView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.StartupView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.StartupView(),
        settings: data,
      );
    },
    _i3.OnboardingView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.OnboardingView(),
        settings: data,
      );
    },
    _i4.SignUpView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.SignUpView(),
        settings: data,
      );
    },
    _i5.LoginView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.LoginView(),
        settings: data,
      );
    },
    _i6.UserDetailsView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.UserDetailsView(),
        settings: data,
      );
    },
    _i7.BottomNavBarView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.BottomNavBarView(),
        settings: data,
      );
    },
    _i8.SavedRecipesView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.SavedRecipesView(),
        settings: data,
      );
    },
    _i9.ChatView: (data) {
      final args = data.getArgs<ChatViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.ChatView(
            receiver: args.receiver,
            conversationId: args.conversationId,
            key: args.key),
        settings: data,
      );
    },
    _i10.ProfileView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.ProfileView(),
        settings: data,
      );
    },
    _i11.SettingsView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.SettingsView(),
        settings: data,
      );
    },
    _i12.FilterView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.FilterView(),
        settings: data,
      );
    },
    _i13.IndexView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.IndexView(),
        settings: data,
      );
    },
    _i14.AddRecipeView: (data) {
      final args = data.getArgs<AddRecipeViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i14.AddRecipeView(args.ingredientsList, key: args.key),
        settings: data,
      );
    },
    _i15.ComingsoonView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i15.ComingsoonView(),
        settings: data,
      );
    },
    _i16.RecipeListPageView: (data) {
      final args = data.getArgs<RecipeListPageViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i16.RecipeListPageView(
            key: args.key, isFromProfileView: args.isFromProfileView),
        settings: data,
      );
    },
    _i17.PinDropMapView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i17.PinDropMapView(),
        settings: data,
      );
    },
    _i18.FollowingListView: (data) {
      final args = data.getArgs<FollowingListViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i18.FollowingListView(key: args.key, user: args.user),
        settings: data,
      );
    },
    _i19.RecipeViewView: (data) {
      final args = data.getArgs<RecipeViewViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i19.RecipeViewView(
            args.recipeModel, args.selectedImages,
            key: args.key, waveFormData: args.waveFormData, path: args.path),
        settings: data,
      );
    },
    _i20.BottomBarGuestView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i20.BottomBarGuestView(),
        settings: data,
      );
    },
    _i21.SavedRecipeDetailsView: (data) {
      final args = data.getArgs<SavedRecipeDetailsViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i21.SavedRecipeDetailsView(
            key: args.key, recipeModel: args.recipeModel),
        settings: data,
      );
    },
    _i22.ChefProfileView: (data) {
      final args = data.getArgs<ChefProfileViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i22.ChefProfileView(user: args.user, key: args.key),
        settings: data,
      );
    },
    _i23.ChatListView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i23.ChatListView(),
        settings: data,
      );
    },
    _i24.EditProfileView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i24.EditProfileView(),
        settings: data,
      );
    },
    _i25.VideoPlayerView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i25.VideoPlayerView(),
        settings: data,
      );
    },
    _i26.AllChefsView: (data) {
      final args = data.getArgs<AllChefsViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i26.AllChefsView(key: args.key, chefList: args.chefList),
        settings: data,
      );
    },
    _i27.ForgetPasswordView: (data) {
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => const _i27.ForgetPasswordView(),
        settings: data,
      );
    },
    _i28.BlockedAccountsView: (data) {
      final args = data.getArgs<BlockedAccountsViewArguments>(nullOk: false);
      return _i29.MaterialPageRoute<dynamic>(
        builder: (context) => _i28.BlockedAccountsView(
            key: args.key, blockedUserList: args.blockedUserList),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class ChatViewArguments {
  const ChatViewArguments({
    required this.receiver,
    required this.conversationId,
    this.key,
  });

  final _i30.UserModel receiver;

  final String conversationId;

  final _i31.Key? key;

  @override
  String toString() {
    return '{"receiver": "$receiver", "conversationId": "$conversationId", "key": "$key"}';
  }

  @override
  bool operator ==(covariant ChatViewArguments other) {
    if (identical(this, other)) return true;
    return other.receiver == receiver &&
        other.conversationId == conversationId &&
        other.key == key;
  }

  @override
  int get hashCode {
    return receiver.hashCode ^ conversationId.hashCode ^ key.hashCode;
  }
}

class AddRecipeViewArguments {
  const AddRecipeViewArguments({
    required this.ingredientsList,
    this.key,
  });

  final List<_i32.Ingredient>? ingredientsList;

  final _i31.Key? key;

  @override
  String toString() {
    return '{"ingredientsList": "$ingredientsList", "key": "$key"}';
  }

  @override
  bool operator ==(covariant AddRecipeViewArguments other) {
    if (identical(this, other)) return true;
    return other.ingredientsList == ingredientsList && other.key == key;
  }

  @override
  int get hashCode {
    return ingredientsList.hashCode ^ key.hashCode;
  }
}

class RecipeListPageViewArguments {
  const RecipeListPageViewArguments({
    this.key,
    required this.isFromProfileView,
  });

  final _i31.Key? key;

  final bool isFromProfileView;

  @override
  String toString() {
    return '{"key": "$key", "isFromProfileView": "$isFromProfileView"}';
  }

  @override
  bool operator ==(covariant RecipeListPageViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.isFromProfileView == isFromProfileView;
  }

  @override
  int get hashCode {
    return key.hashCode ^ isFromProfileView.hashCode;
  }
}

class FollowingListViewArguments {
  const FollowingListViewArguments({
    this.key,
    required this.user,
  });

  final _i31.Key? key;

  final _i30.UserModel user;

  @override
  String toString() {
    return '{"key": "$key", "user": "$user"}';
  }

  @override
  bool operator ==(covariant FollowingListViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.user == user;
  }

  @override
  int get hashCode {
    return key.hashCode ^ user.hashCode;
  }
}

class RecipeViewViewArguments {
  const RecipeViewViewArguments({
    required this.recipeModel,
    required this.selectedImages,
    this.key,
    this.waveFormData,
    this.path,
  });

  final _i33.RecipeModel recipeModel;

  final List<_i34.XFile>? selectedImages;

  final _i31.Key? key;

  final List<double>? waveFormData;

  final String? path;

  @override
  String toString() {
    return '{"recipeModel": "$recipeModel", "selectedImages": "$selectedImages", "key": "$key", "waveFormData": "$waveFormData", "path": "$path"}';
  }

  @override
  bool operator ==(covariant RecipeViewViewArguments other) {
    if (identical(this, other)) return true;
    return other.recipeModel == recipeModel &&
        other.selectedImages == selectedImages &&
        other.key == key &&
        other.waveFormData == waveFormData &&
        other.path == path;
  }

  @override
  int get hashCode {
    return recipeModel.hashCode ^
        selectedImages.hashCode ^
        key.hashCode ^
        waveFormData.hashCode ^
        path.hashCode;
  }
}

class SavedRecipeDetailsViewArguments {
  const SavedRecipeDetailsViewArguments({
    this.key,
    required this.recipeModel,
  });

  final _i31.Key? key;

  final _i33.RecipeModel recipeModel;

  @override
  String toString() {
    return '{"key": "$key", "recipeModel": "$recipeModel"}';
  }

  @override
  bool operator ==(covariant SavedRecipeDetailsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.recipeModel == recipeModel;
  }

  @override
  int get hashCode {
    return key.hashCode ^ recipeModel.hashCode;
  }
}

class ChefProfileViewArguments {
  const ChefProfileViewArguments({
    required this.user,
    this.key,
  });

  final _i30.UserModel user;

  final _i31.Key? key;

  @override
  String toString() {
    return '{"user": "$user", "key": "$key"}';
  }

  @override
  bool operator ==(covariant ChefProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.user == user && other.key == key;
  }

  @override
  int get hashCode {
    return user.hashCode ^ key.hashCode;
  }
}

class AllChefsViewArguments {
  const AllChefsViewArguments({
    this.key,
    required this.chefList,
  });

  final _i31.Key? key;

  final List<_i30.UserModel> chefList;

  @override
  String toString() {
    return '{"key": "$key", "chefList": "$chefList"}';
  }

  @override
  bool operator ==(covariant AllChefsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.chefList == chefList;
  }

  @override
  int get hashCode {
    return key.hashCode ^ chefList.hashCode;
  }
}

class BlockedAccountsViewArguments {
  const BlockedAccountsViewArguments({
    this.key,
    required this.blockedUserList,
  });

  final _i31.Key? key;

  final List<String> blockedUserList;

  @override
  String toString() {
    return '{"key": "$key", "blockedUserList": "$blockedUserList"}';
  }

  @override
  bool operator ==(covariant BlockedAccountsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.blockedUserList == blockedUserList;
  }

  @override
  int get hashCode {
    return key.hashCode ^ blockedUserList.hashCode;
  }
}

extension NavigatorStateExtension on _i35.NavigationService {
  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOnboardingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.onboardingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSignUpView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.signUpView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUserDetailsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.userDetailsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBottomNavBarView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.bottomNavBarView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSavedRecipesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.savedRecipesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChatView({
    required _i30.UserModel receiver,
    required String conversationId,
    _i31.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.chatView,
        arguments: ChatViewArguments(
            receiver: receiver, conversationId: conversationId, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFilterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.filterView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToIndexView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.indexView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddRecipeView({
    required List<_i32.Ingredient>? ingredientsList,
    _i31.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addRecipeView,
        arguments:
            AddRecipeViewArguments(ingredientsList: ingredientsList, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToComingsoonView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.comingsoonView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRecipeListPageView({
    _i31.Key? key,
    required bool isFromProfileView,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.recipeListPageView,
        arguments: RecipeListPageViewArguments(
            key: key, isFromProfileView: isFromProfileView),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPinDropMapView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.pinDropMapView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFollowingListView({
    _i31.Key? key,
    required _i30.UserModel user,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.followingListView,
        arguments: FollowingListViewArguments(key: key, user: user),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRecipeViewView({
    required _i33.RecipeModel recipeModel,
    required List<_i34.XFile>? selectedImages,
    _i31.Key? key,
    List<double>? waveFormData,
    String? path,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.recipeViewView,
        arguments: RecipeViewViewArguments(
            recipeModel: recipeModel,
            selectedImages: selectedImages,
            key: key,
            waveFormData: waveFormData,
            path: path),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBottomBarGuestView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.bottomBarGuestView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSavedRecipeDetailsView({
    _i31.Key? key,
    required _i33.RecipeModel recipeModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.savedRecipeDetailsView,
        arguments:
            SavedRecipeDetailsViewArguments(key: key, recipeModel: recipeModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChefProfileView({
    required _i30.UserModel user,
    _i31.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.chefProfileView,
        arguments: ChefProfileViewArguments(user: user, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChatListView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.chatListView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.editProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToVideoPlayerView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.videoPlayerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAllChefsView({
    _i31.Key? key,
    required List<_i30.UserModel> chefList,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.allChefsView,
        arguments: AllChefsViewArguments(key: key, chefList: chefList),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToForgetPasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.forgetPasswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBlockedAccountsView({
    _i31.Key? key,
    required List<String> blockedUserList,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.blockedAccountsView,
        arguments: BlockedAccountsViewArguments(
            key: key, blockedUserList: blockedUserList),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOnboardingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.onboardingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSignUpView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.signUpView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUserDetailsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.userDetailsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBottomNavBarView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.bottomNavBarView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSavedRecipesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.savedRecipesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChatView({
    required _i30.UserModel receiver,
    required String conversationId,
    _i31.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.chatView,
        arguments: ChatViewArguments(
            receiver: receiver, conversationId: conversationId, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFilterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.filterView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithIndexView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.indexView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddRecipeView({
    required List<_i32.Ingredient>? ingredientsList,
    _i31.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addRecipeView,
        arguments:
            AddRecipeViewArguments(ingredientsList: ingredientsList, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithComingsoonView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.comingsoonView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRecipeListPageView({
    _i31.Key? key,
    required bool isFromProfileView,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.recipeListPageView,
        arguments: RecipeListPageViewArguments(
            key: key, isFromProfileView: isFromProfileView),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPinDropMapView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.pinDropMapView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFollowingListView({
    _i31.Key? key,
    required _i30.UserModel user,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.followingListView,
        arguments: FollowingListViewArguments(key: key, user: user),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRecipeViewView({
    required _i33.RecipeModel recipeModel,
    required List<_i34.XFile>? selectedImages,
    _i31.Key? key,
    List<double>? waveFormData,
    String? path,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.recipeViewView,
        arguments: RecipeViewViewArguments(
            recipeModel: recipeModel,
            selectedImages: selectedImages,
            key: key,
            waveFormData: waveFormData,
            path: path),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBottomBarGuestView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.bottomBarGuestView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSavedRecipeDetailsView({
    _i31.Key? key,
    required _i33.RecipeModel recipeModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.savedRecipeDetailsView,
        arguments:
            SavedRecipeDetailsViewArguments(key: key, recipeModel: recipeModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChefProfileView({
    required _i30.UserModel user,
    _i31.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.chefProfileView,
        arguments: ChefProfileViewArguments(user: user, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChatListView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.chatListView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEditProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.editProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithVideoPlayerView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.videoPlayerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAllChefsView({
    _i31.Key? key,
    required List<_i30.UserModel> chefList,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.allChefsView,
        arguments: AllChefsViewArguments(key: key, chefList: chefList),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithForgetPasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.forgetPasswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBlockedAccountsView({
    _i31.Key? key,
    required List<String> blockedUserList,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.blockedAccountsView,
        arguments: BlockedAccountsViewArguments(
            key: key, blockedUserList: blockedUserList),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
