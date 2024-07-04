// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i39;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as _i43;
import 'package:sailing_chefs/core/imports/core_imports.dart' as _i40;
import 'package:sailing_chefs/model/recipe_model.dart' as _i41;
import 'package:sailing_chefs/model/user_model.dart' as _i42;
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_view.dart' as _i13;
import 'package:sailing_chefs/ui/views/all_chefs/all_chefs_view.dart' as _i25;
import 'package:sailing_chefs/ui/views/becomechef/becomechef_view.dart' as _i28;
import 'package:sailing_chefs/ui/views/blocked_accounts/blocked_accounts_view.dart'
    as _i27;
import 'package:sailing_chefs/ui/views/bottom_bar_guest/bottom_bar_guest_view.dart'
    as _i19;
import 'package:sailing_chefs/ui/views/bottom_nav_bar/bottom_nav_bar_view.dart'
    as _i7;
import 'package:sailing_chefs/ui/views/chat_list/chat_list_view.dart' as _i22;
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_view.dart'
    as _i21;
import 'package:sailing_chefs/ui/views/comingsoon/comingsoon_view.dart' as _i14;
import 'package:sailing_chefs/ui/views/culineryschoolviewall/culineryschoolviewall_view.dart'
    as _i30;
import 'package:sailing_chefs/ui/views/cullinary_savedrecipes/cullinary_savedrecipes_view.dart'
    as _i35;
import 'package:sailing_chefs/ui/views/edit_profile/edit_profile_view.dart'
    as _i23;
import 'package:sailing_chefs/ui/views/explore_all_recipes/explore_all_recipes_view.dart'
    as _i32;
import 'package:sailing_chefs/ui/views/feedback/feedback_view.dart' as _i38;
import 'package:sailing_chefs/ui/views/filter/filter_view.dart' as _i11;
import 'package:sailing_chefs/ui/views/following_list/following_list_view.dart'
    as _i17;
import 'package:sailing_chefs/ui/views/forget_password/forget_password_view.dart'
    as _i26;
import 'package:sailing_chefs/ui/views/index/index_view.dart' as _i12;
import 'package:sailing_chefs/ui/views/login/login_view.dart' as _i5;
import 'package:sailing_chefs/ui/views/Messages/chat_view.dart' as _i31;
import 'package:sailing_chefs/ui/views/onboarding/onboarding_view.dart' as _i3;
import 'package:sailing_chefs/ui/views/pin_drop_map/pin_drop_map_view.dart'
    as _i16;
import 'package:sailing_chefs/ui/views/privacy_policy/privacy_policy_view.dart'
    as _i29;
import 'package:sailing_chefs/ui/views/private_recipes/private_recipes_view.dart'
    as _i36;
import 'package:sailing_chefs/ui/views/profile/profile_view.dart' as _i9;
import 'package:sailing_chefs/ui/views/recipe_list_page/recipe_list_page_view.dart'
    as _i15;
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_view.dart'
    as _i18;
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_view.dart'
    as _i20;
import 'package:sailing_chefs/ui/views/saved_recipes/saved_recipes_view.dart'
    as _i8;
import 'package:sailing_chefs/ui/views/search/search_view.dart' as _i34;
import 'package:sailing_chefs/ui/views/settings/settings_view.dart' as _i10;
import 'package:sailing_chefs/ui/views/shopping_list/shopping_list_view.dart'
    as _i37;
import 'package:sailing_chefs/ui/views/sign_up/sign_up_view.dart' as _i4;
import 'package:sailing_chefs/ui/views/startup/startup_view.dart' as _i2;
import 'package:sailing_chefs/ui/views/user_details/user_details_view.dart'
    as _i6;
import 'package:sailing_chefs/ui/views/video_player/video_player_view.dart'
    as _i24;
import 'package:sailing_chefs/ui/views/view_all_drafts/view_all_drafts_view.dart'
    as _i33;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i44;

class Routes {
  static const startupView = '/startup-view';

  static const onboardingView = '/onboarding-view';

  static const signUpView = '/sign-up-view';

  static const loginView = '/login-view';

  static const userDetailsView = '/user-details-view';

  static const bottomNavBarView = '/bottom-nav-bar-view';

  static const savedRecipesView = '/saved-recipes-view';

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

  static const becomechefView = '/becomechef-view';

  static const privacyPolicyView = '/privacy-policy-view';

  static const culineryschoolviewallView = '/culineryschoolviewall-view';

  static const chatView = '/chat-view';

  static const exploreAllRecipesView = '/explore-all-recipes-view';

  static const viewAllDraftsView = '/view-all-drafts-view';

  static const searchView = '/search-view';

  static const cullinarySavedrecipesView = '/cullinary-savedrecipes-view';

  static const privateRecipesView = '/private-recipes-view';

  static const shoppingListView = '/shopping-list-view';

  static const feedbackView = '/feedback-view';

  static const all = <String>{
    startupView,
    onboardingView,
    signUpView,
    loginView,
    userDetailsView,
    bottomNavBarView,
    savedRecipesView,
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
    becomechefView,
    privacyPolicyView,
    culineryschoolviewallView,
    chatView,
    exploreAllRecipesView,
    viewAllDraftsView,
    searchView,
    cullinarySavedrecipesView,
    privateRecipesView,
    shoppingListView,
    feedbackView,
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
      Routes.profileView,
      page: _i9.ProfileView,
    ),
    _i1.RouteDef(
      Routes.settingsView,
      page: _i10.SettingsView,
    ),
    _i1.RouteDef(
      Routes.filterView,
      page: _i11.FilterView,
    ),
    _i1.RouteDef(
      Routes.indexView,
      page: _i12.IndexView,
    ),
    _i1.RouteDef(
      Routes.addRecipeView,
      page: _i13.AddRecipeView,
    ),
    _i1.RouteDef(
      Routes.comingsoonView,
      page: _i14.ComingsoonView,
    ),
    _i1.RouteDef(
      Routes.recipeListPageView,
      page: _i15.RecipeListPageView,
    ),
    _i1.RouteDef(
      Routes.pinDropMapView,
      page: _i16.PinDropMapView,
    ),
    _i1.RouteDef(
      Routes.followingListView,
      page: _i17.FollowingListView,
    ),
    _i1.RouteDef(
      Routes.recipeViewView,
      page: _i18.RecipeViewView,
    ),
    _i1.RouteDef(
      Routes.bottomBarGuestView,
      page: _i19.BottomBarGuestView,
    ),
    _i1.RouteDef(
      Routes.savedRecipeDetailsView,
      page: _i20.SavedRecipeDetailsView,
    ),
    _i1.RouteDef(
      Routes.chefProfileView,
      page: _i21.ChefProfileView,
    ),
    _i1.RouteDef(
      Routes.chatListView,
      page: _i22.ChatListView,
    ),
    _i1.RouteDef(
      Routes.editProfileView,
      page: _i23.EditProfileView,
    ),
    _i1.RouteDef(
      Routes.videoPlayerView,
      page: _i24.VideoPlayerView,
    ),
    _i1.RouteDef(
      Routes.allChefsView,
      page: _i25.AllChefsView,
    ),
    _i1.RouteDef(
      Routes.forgetPasswordView,
      page: _i26.ForgetPasswordView,
    ),
    _i1.RouteDef(
      Routes.blockedAccountsView,
      page: _i27.BlockedAccountsView,
    ),
    _i1.RouteDef(
      Routes.becomechefView,
      page: _i28.BecomechefView,
    ),
    _i1.RouteDef(
      Routes.privacyPolicyView,
      page: _i29.PrivacyPolicyView,
    ),
    _i1.RouteDef(
      Routes.culineryschoolviewallView,
      page: _i30.CulineryschoolviewallView,
    ),
    _i1.RouteDef(
      Routes.chatView,
      page: _i31.ChatView,
    ),
    _i1.RouteDef(
      Routes.exploreAllRecipesView,
      page: _i32.ExploreAllRecipesView,
    ),
    _i1.RouteDef(
      Routes.viewAllDraftsView,
      page: _i33.ViewAllDraftsView,
    ),
    _i1.RouteDef(
      Routes.searchView,
      page: _i34.SearchView,
    ),
    _i1.RouteDef(
      Routes.cullinarySavedrecipesView,
      page: _i35.CullinarySavedrecipesView,
    ),
    _i1.RouteDef(
      Routes.privateRecipesView,
      page: _i36.PrivateRecipesView,
    ),
    _i1.RouteDef(
      Routes.shoppingListView,
      page: _i37.ShoppingListView,
    ),
    _i1.RouteDef(
      Routes.feedbackView,
      page: _i38.FeedbackView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.StartupView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.StartupView(),
        settings: data,
      );
    },
    _i3.OnboardingView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.OnboardingView(),
        settings: data,
      );
    },
    _i4.SignUpView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.SignUpView(),
        settings: data,
      );
    },
    _i5.LoginView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.LoginView(),
        settings: data,
      );
    },
    _i6.UserDetailsView: (data) {
      final args = data.getArgs<UserDetailsViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i6.UserDetailsView(key: args.key, userRole: args.userRole),
        settings: data,
      );
    },
    _i7.BottomNavBarView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.BottomNavBarView(),
        settings: data,
      );
    },
    _i8.SavedRecipesView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.SavedRecipesView(),
        settings: data,
      );
    },
    _i9.ProfileView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.ProfileView(),
        settings: data,
      );
    },
    _i10.SettingsView: (data) {
      final args = data.getArgs<SettingsViewArguments>(
        orElse: () => const SettingsViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.SettingsView(
            key: args.key, isCurrentUser: args.isCurrentUser, uid: args.uid),
        settings: data,
      );
    },
    _i11.FilterView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.FilterView(),
        settings: data,
      );
    },
    _i12.IndexView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.IndexView(),
        settings: data,
      );
    },
    _i13.AddRecipeView: (data) {
      final args = data.getArgs<AddRecipeViewArguments>(
        orElse: () => const AddRecipeViewArguments(),
      );
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i13.AddRecipeView(drafts: args.drafts, key: args.key),
        settings: data,
      );
    },
    _i14.ComingsoonView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.ComingsoonView(),
        settings: data,
      );
    },
    _i15.RecipeListPageView: (data) {
      final args = data.getArgs<RecipeListPageViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i15.RecipeListPageView(
            key: args.key, isFromDraft: args.isFromDraft),
        settings: data,
      );
    },
    _i16.PinDropMapView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i16.PinDropMapView(),
        settings: data,
      );
    },
    _i17.FollowingListView: (data) {
      final args = data.getArgs<FollowingListViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i17.FollowingListView(
            key: args.key,
            user: args.user,
            isfromFollowing: args.isfromFollowing),
        settings: data,
      );
    },
    _i18.RecipeViewView: (data) {
      final args = data.getArgs<RecipeViewViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i18.RecipeViewView(
            args.recipeModel, args.selectedImages, args.draftUrls,
            key: args.key,
            waveFormData: args.waveFormData,
            path: args.path,
            isFromDraft: args.isFromDraft),
        settings: data,
      );
    },
    _i19.BottomBarGuestView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i19.BottomBarGuestView(),
        settings: data,
      );
    },
    _i20.SavedRecipeDetailsView: (data) {
      final args = data.getArgs<SavedRecipeDetailsViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i20.SavedRecipeDetailsView(
            key: args.key,
            recipeModel: args.recipeModel,
            isFromPrivateProfile: args.isFromPrivateProfile,
            randomRecipeList: args.randomRecipeList),
        settings: data,
      );
    },
    _i21.ChefProfileView: (data) {
      final args = data.getArgs<ChefProfileViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i21.ChefProfileView(user: args.user, key: args.key),
        settings: data,
      );
    },
    _i22.ChatListView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i22.ChatListView(),
        settings: data,
      );
    },
    _i23.EditProfileView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i23.EditProfileView(),
        settings: data,
      );
    },
    _i24.VideoPlayerView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i24.VideoPlayerView(),
        settings: data,
      );
    },
    _i25.AllChefsView: (data) {
      final args = data.getArgs<AllChefsViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i25.AllChefsView(key: args.key, chefList: args.chefList),
        settings: data,
      );
    },
    _i26.ForgetPasswordView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i26.ForgetPasswordView(),
        settings: data,
      );
    },
    _i27.BlockedAccountsView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i27.BlockedAccountsView(),
        settings: data,
      );
    },
    _i28.BecomechefView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i28.BecomechefView(),
        settings: data,
      );
    },
    _i29.PrivacyPolicyView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i29.PrivacyPolicyView(),
        settings: data,
      );
    },
    _i30.CulineryschoolviewallView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i30.CulineryschoolviewallView(),
        settings: data,
      );
    },
    _i31.ChatView: (data) {
      final args = data.getArgs<ChatViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i31.ChatView(
            receiver: args.receiver,
            conversationId: args.conversationId,
            key: args.key,
            messageFromCource: args.messageFromCource),
        settings: data,
      );
    },
    _i32.ExploreAllRecipesView: (data) {
      final args = data.getArgs<ExploreAllRecipesViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i32.ExploreAllRecipesView(key: args.key, recipes: args.recipes),
        settings: data,
      );
    },
    _i33.ViewAllDraftsView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i33.ViewAllDraftsView(),
        settings: data,
      );
    },
    _i34.SearchView: (data) {
      final args = data.getArgs<SearchViewArguments>(nullOk: false);
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i34.SearchView(
            key: args.key,
            recipeModel: args.recipeModel,
            chefList: args.chefList,
            selectedTagsCount: args.selectedTagsCount),
        settings: data,
      );
    },
    _i35.CullinarySavedrecipesView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i35.CullinarySavedrecipesView(),
        settings: data,
      );
    },
    _i36.PrivateRecipesView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i36.PrivateRecipesView(),
        settings: data,
      );
    },
    _i37.ShoppingListView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => _i37.ShoppingListView(),
        settings: data,
      );
    },
    _i38.FeedbackView: (data) {
      return _i39.MaterialPageRoute<dynamic>(
        builder: (context) => const _i38.FeedbackView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class UserDetailsViewArguments {
  const UserDetailsViewArguments({
    this.key,
    required this.userRole,
  });

  final _i40.Key? key;

  final String userRole;

  @override
  String toString() {
    return '{"key": "$key", "userRole": "$userRole"}';
  }

  @override
  bool operator ==(covariant UserDetailsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.userRole == userRole;
  }

  @override
  int get hashCode {
    return key.hashCode ^ userRole.hashCode;
  }
}

class SettingsViewArguments {
  const SettingsViewArguments({
    this.key,
    this.isCurrentUser,
    this.uid,
  });

  final _i40.Key? key;

  final bool? isCurrentUser;

  final String? uid;

  @override
  String toString() {
    return '{"key": "$key", "isCurrentUser": "$isCurrentUser", "uid": "$uid"}';
  }

  @override
  bool operator ==(covariant SettingsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.isCurrentUser == isCurrentUser &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return key.hashCode ^ isCurrentUser.hashCode ^ uid.hashCode;
  }
}

class AddRecipeViewArguments {
  const AddRecipeViewArguments({
    this.drafts,
    this.key,
  });

  final _i41.RecipeModel? drafts;

  final _i40.Key? key;

  @override
  String toString() {
    return '{"drafts": "$drafts", "key": "$key"}';
  }

  @override
  bool operator ==(covariant AddRecipeViewArguments other) {
    if (identical(this, other)) return true;
    return other.drafts == drafts && other.key == key;
  }

  @override
  int get hashCode {
    return drafts.hashCode ^ key.hashCode;
  }
}

class RecipeListPageViewArguments {
  const RecipeListPageViewArguments({
    this.key,
    required this.isFromDraft,
  });

  final _i40.Key? key;

  final bool isFromDraft;

  @override
  String toString() {
    return '{"key": "$key", "isFromDraft": "$isFromDraft"}';
  }

  @override
  bool operator ==(covariant RecipeListPageViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.isFromDraft == isFromDraft;
  }

  @override
  int get hashCode {
    return key.hashCode ^ isFromDraft.hashCode;
  }
}

class FollowingListViewArguments {
  const FollowingListViewArguments({
    this.key,
    required this.user,
    required this.isfromFollowing,
  });

  final _i40.Key? key;

  final _i42.UserModel user;

  final bool isfromFollowing;

  @override
  String toString() {
    return '{"key": "$key", "user": "$user", "isfromFollowing": "$isfromFollowing"}';
  }

  @override
  bool operator ==(covariant FollowingListViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.user == user &&
        other.isfromFollowing == isfromFollowing;
  }

  @override
  int get hashCode {
    return key.hashCode ^ user.hashCode ^ isfromFollowing.hashCode;
  }
}

class RecipeViewViewArguments {
  const RecipeViewViewArguments({
    required this.recipeModel,
    required this.selectedImages,
    required this.draftUrls,
    this.key,
    this.waveFormData,
    this.path,
    required this.isFromDraft,
  });

  final _i41.RecipeModel recipeModel;

  final List<_i43.XFile> selectedImages;

  final List<String> draftUrls;

  final _i40.Key? key;

  final List<double>? waveFormData;

  final String? path;

  final bool isFromDraft;

  @override
  String toString() {
    return '{"recipeModel": "$recipeModel", "selectedImages": "$selectedImages", "draftUrls": "$draftUrls", "key": "$key", "waveFormData": "$waveFormData", "path": "$path", "isFromDraft": "$isFromDraft"}';
  }

  @override
  bool operator ==(covariant RecipeViewViewArguments other) {
    if (identical(this, other)) return true;
    return other.recipeModel == recipeModel &&
        other.selectedImages == selectedImages &&
        other.draftUrls == draftUrls &&
        other.key == key &&
        other.waveFormData == waveFormData &&
        other.path == path &&
        other.isFromDraft == isFromDraft;
  }

  @override
  int get hashCode {
    return recipeModel.hashCode ^
        selectedImages.hashCode ^
        draftUrls.hashCode ^
        key.hashCode ^
        waveFormData.hashCode ^
        path.hashCode ^
        isFromDraft.hashCode;
  }
}

class SavedRecipeDetailsViewArguments {
  const SavedRecipeDetailsViewArguments({
    this.key,
    required this.recipeModel,
    required this.isFromPrivateProfile,
    required this.randomRecipeList,
  });

  final _i40.Key? key;

  final _i41.RecipeModel recipeModel;

  final bool isFromPrivateProfile;

  final List<_i41.RecipeModel> randomRecipeList;

  @override
  String toString() {
    return '{"key": "$key", "recipeModel": "$recipeModel", "isFromPrivateProfile": "$isFromPrivateProfile", "randomRecipeList": "$randomRecipeList"}';
  }

  @override
  bool operator ==(covariant SavedRecipeDetailsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.recipeModel == recipeModel &&
        other.isFromPrivateProfile == isFromPrivateProfile &&
        other.randomRecipeList == randomRecipeList;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        recipeModel.hashCode ^
        isFromPrivateProfile.hashCode ^
        randomRecipeList.hashCode;
  }
}

class ChefProfileViewArguments {
  const ChefProfileViewArguments({
    required this.user,
    this.key,
  });

  final _i42.UserModel user;

  final _i40.Key? key;

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

  final _i40.Key? key;

  final List<_i42.UserModel> chefList;

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

class ChatViewArguments {
  const ChatViewArguments({
    required this.receiver,
    required this.conversationId,
    this.key,
    required this.messageFromCource,
  });

  final _i42.UserModel receiver;

  final String conversationId;

  final _i40.Key? key;

  final String? messageFromCource;

  @override
  String toString() {
    return '{"receiver": "$receiver", "conversationId": "$conversationId", "key": "$key", "messageFromCource": "$messageFromCource"}';
  }

  @override
  bool operator ==(covariant ChatViewArguments other) {
    if (identical(this, other)) return true;
    return other.receiver == receiver &&
        other.conversationId == conversationId &&
        other.key == key &&
        other.messageFromCource == messageFromCource;
  }

  @override
  int get hashCode {
    return receiver.hashCode ^
        conversationId.hashCode ^
        key.hashCode ^
        messageFromCource.hashCode;
  }
}

class ExploreAllRecipesViewArguments {
  const ExploreAllRecipesViewArguments({
    this.key,
    required this.recipes,
  });

  final _i40.Key? key;

  final List<_i41.RecipeModel> recipes;

  @override
  String toString() {
    return '{"key": "$key", "recipes": "$recipes"}';
  }

  @override
  bool operator ==(covariant ExploreAllRecipesViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.recipes == recipes;
  }

  @override
  int get hashCode {
    return key.hashCode ^ recipes.hashCode;
  }
}

class SearchViewArguments {
  const SearchViewArguments({
    this.key,
    required this.recipeModel,
    required this.chefList,
    required this.selectedTagsCount,
  });

  final _i40.Key? key;

  final List<_i41.RecipeModel> recipeModel;

  final List<_i42.UserModel> chefList;

  final int selectedTagsCount;

  @override
  String toString() {
    return '{"key": "$key", "recipeModel": "$recipeModel", "chefList": "$chefList", "selectedTagsCount": "$selectedTagsCount"}';
  }

  @override
  bool operator ==(covariant SearchViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.recipeModel == recipeModel &&
        other.chefList == chefList &&
        other.selectedTagsCount == selectedTagsCount;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        recipeModel.hashCode ^
        chefList.hashCode ^
        selectedTagsCount.hashCode;
  }
}

extension NavigatorStateExtension on _i44.NavigationService {
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

  Future<dynamic> navigateToUserDetailsView({
    _i40.Key? key,
    required String userRole,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.userDetailsView,
        arguments: UserDetailsViewArguments(key: key, userRole: userRole),
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

  Future<dynamic> navigateToSettingsView({
    _i40.Key? key,
    bool? isCurrentUser,
    String? uid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.settingsView,
        arguments: SettingsViewArguments(
            key: key, isCurrentUser: isCurrentUser, uid: uid),
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
    _i41.RecipeModel? drafts,
    _i40.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.addRecipeView,
        arguments: AddRecipeViewArguments(drafts: drafts, key: key),
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
    _i40.Key? key,
    required bool isFromDraft,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.recipeListPageView,
        arguments:
            RecipeListPageViewArguments(key: key, isFromDraft: isFromDraft),
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
    _i40.Key? key,
    required _i42.UserModel user,
    required bool isfromFollowing,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.followingListView,
        arguments: FollowingListViewArguments(
            key: key, user: user, isfromFollowing: isfromFollowing),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRecipeViewView({
    required _i41.RecipeModel recipeModel,
    required List<_i43.XFile> selectedImages,
    required List<String> draftUrls,
    _i40.Key? key,
    List<double>? waveFormData,
    String? path,
    required bool isFromDraft,
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
            draftUrls: draftUrls,
            key: key,
            waveFormData: waveFormData,
            path: path,
            isFromDraft: isFromDraft),
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
    _i40.Key? key,
    required _i41.RecipeModel recipeModel,
    required bool isFromPrivateProfile,
    required List<_i41.RecipeModel> randomRecipeList,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.savedRecipeDetailsView,
        arguments: SavedRecipeDetailsViewArguments(
            key: key,
            recipeModel: recipeModel,
            isFromPrivateProfile: isFromPrivateProfile,
            randomRecipeList: randomRecipeList),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChefProfileView({
    required _i42.UserModel user,
    _i40.Key? key,
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
    _i40.Key? key,
    required List<_i42.UserModel> chefList,
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

  Future<dynamic> navigateToBlockedAccountsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.blockedAccountsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBecomechefView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.becomechefView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPrivacyPolicyView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.privacyPolicyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCulineryschoolviewallView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.culineryschoolviewallView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChatView({
    required _i42.UserModel receiver,
    required String conversationId,
    _i40.Key? key,
    required String? messageFromCource,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.chatView,
        arguments: ChatViewArguments(
            receiver: receiver,
            conversationId: conversationId,
            key: key,
            messageFromCource: messageFromCource),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToExploreAllRecipesView({
    _i40.Key? key,
    required List<_i41.RecipeModel> recipes,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.exploreAllRecipesView,
        arguments: ExploreAllRecipesViewArguments(key: key, recipes: recipes),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToViewAllDraftsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.viewAllDraftsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSearchView({
    _i40.Key? key,
    required List<_i41.RecipeModel> recipeModel,
    required List<_i42.UserModel> chefList,
    required int selectedTagsCount,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.searchView,
        arguments: SearchViewArguments(
            key: key,
            recipeModel: recipeModel,
            chefList: chefList,
            selectedTagsCount: selectedTagsCount),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCullinarySavedrecipesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.cullinarySavedrecipesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPrivateRecipesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.privateRecipesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToShoppingListView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.shoppingListView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFeedbackView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.feedbackView,
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

  Future<dynamic> replaceWithUserDetailsView({
    _i40.Key? key,
    required String userRole,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.userDetailsView,
        arguments: UserDetailsViewArguments(key: key, userRole: userRole),
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

  Future<dynamic> replaceWithSettingsView({
    _i40.Key? key,
    bool? isCurrentUser,
    String? uid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.settingsView,
        arguments: SettingsViewArguments(
            key: key, isCurrentUser: isCurrentUser, uid: uid),
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
    _i41.RecipeModel? drafts,
    _i40.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.addRecipeView,
        arguments: AddRecipeViewArguments(drafts: drafts, key: key),
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
    _i40.Key? key,
    required bool isFromDraft,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.recipeListPageView,
        arguments:
            RecipeListPageViewArguments(key: key, isFromDraft: isFromDraft),
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
    _i40.Key? key,
    required _i42.UserModel user,
    required bool isfromFollowing,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.followingListView,
        arguments: FollowingListViewArguments(
            key: key, user: user, isfromFollowing: isfromFollowing),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRecipeViewView({
    required _i41.RecipeModel recipeModel,
    required List<_i43.XFile> selectedImages,
    required List<String> draftUrls,
    _i40.Key? key,
    List<double>? waveFormData,
    String? path,
    required bool isFromDraft,
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
            draftUrls: draftUrls,
            key: key,
            waveFormData: waveFormData,
            path: path,
            isFromDraft: isFromDraft),
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
    _i40.Key? key,
    required _i41.RecipeModel recipeModel,
    required bool isFromPrivateProfile,
    required List<_i41.RecipeModel> randomRecipeList,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.savedRecipeDetailsView,
        arguments: SavedRecipeDetailsViewArguments(
            key: key,
            recipeModel: recipeModel,
            isFromPrivateProfile: isFromPrivateProfile,
            randomRecipeList: randomRecipeList),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChefProfileView({
    required _i42.UserModel user,
    _i40.Key? key,
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
    _i40.Key? key,
    required List<_i42.UserModel> chefList,
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

  Future<dynamic> replaceWithBlockedAccountsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.blockedAccountsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBecomechefView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.becomechefView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPrivacyPolicyView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.privacyPolicyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCulineryschoolviewallView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.culineryschoolviewallView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChatView({
    required _i42.UserModel receiver,
    required String conversationId,
    _i40.Key? key,
    required String? messageFromCource,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.chatView,
        arguments: ChatViewArguments(
            receiver: receiver,
            conversationId: conversationId,
            key: key,
            messageFromCource: messageFromCource),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithExploreAllRecipesView({
    _i40.Key? key,
    required List<_i41.RecipeModel> recipes,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.exploreAllRecipesView,
        arguments: ExploreAllRecipesViewArguments(key: key, recipes: recipes),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithViewAllDraftsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.viewAllDraftsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSearchView({
    _i40.Key? key,
    required List<_i41.RecipeModel> recipeModel,
    required List<_i42.UserModel> chefList,
    required int selectedTagsCount,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.searchView,
        arguments: SearchViewArguments(
            key: key,
            recipeModel: recipeModel,
            chefList: chefList,
            selectedTagsCount: selectedTagsCount),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCullinarySavedrecipesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.cullinarySavedrecipesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPrivateRecipesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.privateRecipesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithShoppingListView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.shoppingListView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFeedbackView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.feedbackView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
