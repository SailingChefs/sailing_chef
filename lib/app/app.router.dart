// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as _i41;
import 'package:image_picker/image_picker.dart' as _i45;
import 'package:sailing_chefs/core/imports/core_imports.dart' as _i42;
import 'package:sailing_chefs/model/recipe_model.dart' as _i43;
import 'package:sailing_chefs/model/user_model.dart' as _i44;
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
import 'package:sailing_chefs/ui/views/profile_share/profile_share_view.dart'
    as _i39;
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
import 'package:sailing_chefs/ui/views/share_recipe_to_sailing_cheff_user/share_recipe_to_sailing_cheff_user_view.dart'
    as _i40;
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
import 'package:stacked_services/stacked_services.dart' as _i46;

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

  static const profileShareView = '/profile-share-view';

  static const shareRecipeToSailingCheffUserView =
      '/share-recipe-to-sailing-cheff-user-view';

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
    profileShareView,
    shareRecipeToSailingCheffUserView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(Routes.startupView, page: _i2.StartupView),
    _i1.RouteDef(Routes.onboardingView, page: _i3.OnboardingView),
    _i1.RouteDef(Routes.signUpView, page: _i4.SignUpView),
    _i1.RouteDef(Routes.loginView, page: _i5.LoginView),
    _i1.RouteDef(Routes.userDetailsView, page: _i6.UserDetailsView),
    _i1.RouteDef(Routes.bottomNavBarView, page: _i7.BottomNavBarView),
    _i1.RouteDef(Routes.savedRecipesView, page: _i8.SavedRecipesView),
    _i1.RouteDef(Routes.profileView, page: _i9.ProfileView),
    _i1.RouteDef(Routes.settingsView, page: _i10.SettingsView),
    _i1.RouteDef(Routes.filterView, page: _i11.FilterView),
    _i1.RouteDef(Routes.indexView, page: _i12.IndexView),
    _i1.RouteDef(Routes.addRecipeView, page: _i13.AddRecipeView),
    _i1.RouteDef(Routes.comingsoonView, page: _i14.ComingsoonView),
    _i1.RouteDef(Routes.recipeListPageView, page: _i15.RecipeListPageView),
    _i1.RouteDef(Routes.pinDropMapView, page: _i16.PinDropMapView),
    _i1.RouteDef(Routes.followingListView, page: _i17.FollowingListView),
    _i1.RouteDef(Routes.recipeViewView, page: _i18.RecipeViewView),
    _i1.RouteDef(Routes.bottomBarGuestView, page: _i19.BottomBarGuestView),
    _i1.RouteDef(
      Routes.savedRecipeDetailsView,
      page: _i20.SavedRecipeDetailsView,
    ),
    _i1.RouteDef(Routes.chefProfileView, page: _i21.ChefProfileView),
    _i1.RouteDef(Routes.chatListView, page: _i22.ChatListView),
    _i1.RouteDef(Routes.editProfileView, page: _i23.EditProfileView),
    _i1.RouteDef(Routes.videoPlayerView, page: _i24.VideoPlayerView),
    _i1.RouteDef(Routes.allChefsView, page: _i25.AllChefsView),
    _i1.RouteDef(Routes.forgetPasswordView, page: _i26.ForgetPasswordView),
    _i1.RouteDef(Routes.blockedAccountsView, page: _i27.BlockedAccountsView),
    _i1.RouteDef(Routes.becomechefView, page: _i28.BecomechefView),
    _i1.RouteDef(Routes.privacyPolicyView, page: _i29.PrivacyPolicyView),
    _i1.RouteDef(
      Routes.culineryschoolviewallView,
      page: _i30.CulineryschoolviewallView,
    ),
    _i1.RouteDef(Routes.chatView, page: _i31.ChatView),
    _i1.RouteDef(
      Routes.exploreAllRecipesView,
      page: _i32.ExploreAllRecipesView,
    ),
    _i1.RouteDef(Routes.viewAllDraftsView, page: _i33.ViewAllDraftsView),
    _i1.RouteDef(Routes.searchView, page: _i34.SearchView),
    _i1.RouteDef(
      Routes.cullinarySavedrecipesView,
      page: _i35.CullinarySavedrecipesView,
    ),
    _i1.RouteDef(Routes.privateRecipesView, page: _i36.PrivateRecipesView),
    _i1.RouteDef(Routes.shoppingListView, page: _i37.ShoppingListView),
    _i1.RouteDef(Routes.feedbackView, page: _i38.FeedbackView),
    _i1.RouteDef(Routes.profileShareView, page: _i39.ProfileShareView),
    _i1.RouteDef(
      Routes.shareRecipeToSailingCheffUserView,
      page: _i40.ShareRecipeToSailingCheffUserView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.StartupView: (data) {
      final args = data.getArgs<StartupViewArguments>(
        orElse: () => const StartupViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.StartupView(key: args.key),
        settings: data,
      );
    },
    _i3.OnboardingView: (data) {
      final args = data.getArgs<OnboardingViewArguments>(
        orElse: () => const OnboardingViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.OnboardingView(key: args.key),
        settings: data,
      );
    },
    _i4.SignUpView: (data) {
      final args = data.getArgs<SignUpViewArguments>(
        orElse: () => const SignUpViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.SignUpView(key: args.key),
        settings: data,
      );
    },
    _i5.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.LoginView(key: args.key),
        settings: data,
      );
    },
    _i6.UserDetailsView: (data) {
      final args = data.getArgs<UserDetailsViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i6.UserDetailsView(key: args.key, userRole: args.userRole),
        settings: data,
      );
    },
    _i7.BottomNavBarView: (data) {
      final args = data.getArgs<BottomNavBarViewArguments>(
        orElse: () => const BottomNavBarViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i7.BottomNavBarView(index: args.index, key: args.key),
        settings: data,
      );
    },
    _i8.SavedRecipesView: (data) {
      final args = data.getArgs<SavedRecipesViewArguments>(
        orElse: () => const SavedRecipesViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.SavedRecipesView(key: args.key),
        settings: data,
      );
    },
    _i9.ProfileView: (data) {
      final args = data.getArgs<ProfileViewArguments>(
        orElse: () => const ProfileViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.ProfileView(key: args.key),
        settings: data,
      );
    },
    _i10.SettingsView: (data) {
      final args = data.getArgs<SettingsViewArguments>(
        orElse: () => const SettingsViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.SettingsView(
          key: args.key,
          isCurrentUser: args.isCurrentUser,
          uid: args.uid,
        ),
        settings: data,
      );
    },
    _i11.FilterView: (data) {
      final args = data.getArgs<FilterViewArguments>(
        orElse: () => const FilterViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.FilterView(key: args.key),
        settings: data,
      );
    },
    _i12.IndexView: (data) {
      final args = data.getArgs<IndexViewArguments>(
        orElse: () => const IndexViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.IndexView(key: args.key),
        settings: data,
      );
    },
    _i13.AddRecipeView: (data) {
      final args = data.getArgs<AddRecipeViewArguments>(
        orElse: () => const AddRecipeViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i13.AddRecipeView(drafts: args.drafts, key: args.key),
        settings: data,
      );
    },
    _i14.ComingsoonView: (data) {
      final args = data.getArgs<ComingsoonViewArguments>(
        orElse: () => const ComingsoonViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i14.ComingsoonView(key: args.key),
        settings: data,
      );
    },
    _i15.RecipeListPageView: (data) {
      final args = data.getArgs<RecipeListPageViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i15.RecipeListPageView(
          key: args.key,
          isFromDraft: args.isFromDraft,
        ),
        settings: data,
      );
    },
    _i16.PinDropMapView: (data) {
      final args = data.getArgs<PinDropMapViewArguments>(
        orElse: () => const PinDropMapViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i16.PinDropMapView(key: args.key),
        settings: data,
      );
    },
    _i17.FollowingListView: (data) {
      final args = data.getArgs<FollowingListViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i17.FollowingListView(
          key: args.key,
          user: args.user,
          isfromFollowing: args.isfromFollowing,
        ),
        settings: data,
      );
    },
    _i18.RecipeViewView: (data) {
      final args = data.getArgs<RecipeViewViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i18.RecipeViewView(
          args.recipeModel,
          args.selectedImages,
          args.draftUrls,
          key: args.key,
          waveFormData: args.waveFormData,
          path: args.path,
          isFromDraft: args.isFromDraft,
        ),
        settings: data,
      );
    },
    _i19.BottomBarGuestView: (data) {
      final args = data.getArgs<BottomBarGuestViewArguments>(
        orElse: () => const BottomBarGuestViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i19.BottomBarGuestView(key: args.key),
        settings: data,
      );
    },
    _i20.SavedRecipeDetailsView: (data) {
      final args = data.getArgs<SavedRecipeDetailsViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i20.SavedRecipeDetailsView(
          key: args.key,
          recipeModel: args.recipeModel,
          isFromPrivateProfile: args.isFromPrivateProfile,
          randomRecipeList: args.randomRecipeList,
        ),
        settings: data,
      );
    },
    _i21.ChefProfileView: (data) {
      final args = data.getArgs<ChefProfileViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i21.ChefProfileView(user: args.user, key: args.key),
        settings: data,
      );
    },
    _i22.ChatListView: (data) {
      final args = data.getArgs<ChatListViewArguments>(
        orElse: () => const ChatListViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i22.ChatListView(key: args.key),
        settings: data,
      );
    },
    _i23.EditProfileView: (data) {
      final args = data.getArgs<EditProfileViewArguments>(
        orElse: () => const EditProfileViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i23.EditProfileView(key: args.key),
        settings: data,
      );
    },
    _i24.VideoPlayerView: (data) {
      final args = data.getArgs<VideoPlayerViewArguments>(
        orElse: () => const VideoPlayerViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i24.VideoPlayerView(key: args.key),
        settings: data,
      );
    },
    _i25.AllChefsView: (data) {
      final args = data.getArgs<AllChefsViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i25.AllChefsView(key: args.key, chefList: args.chefList),
        settings: data,
      );
    },
    _i26.ForgetPasswordView: (data) {
      final args = data.getArgs<ForgetPasswordViewArguments>(
        orElse: () => const ForgetPasswordViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i26.ForgetPasswordView(key: args.key),
        settings: data,
      );
    },
    _i27.BlockedAccountsView: (data) {
      final args = data.getArgs<BlockedAccountsViewArguments>(
        orElse: () => const BlockedAccountsViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i27.BlockedAccountsView(key: args.key),
        settings: data,
      );
    },
    _i28.BecomechefView: (data) {
      final args = data.getArgs<BecomechefViewArguments>(
        orElse: () => const BecomechefViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i28.BecomechefView(key: args.key),
        settings: data,
      );
    },
    _i29.PrivacyPolicyView: (data) {
      final args = data.getArgs<PrivacyPolicyViewArguments>(
        orElse: () => const PrivacyPolicyViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i29.PrivacyPolicyView(key: args.key),
        settings: data,
      );
    },
    _i30.CulineryschoolviewallView: (data) {
      final args = data.getArgs<CulineryschoolviewallViewArguments>(
        orElse: () => const CulineryschoolviewallViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i30.CulineryschoolviewallView(key: args.key),
        settings: data,
      );
    },
    _i31.ChatView: (data) {
      final args = data.getArgs<ChatViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i31.ChatView(
          receiver: args.receiver,
          conversationId: args.conversationId,
          key: args.key,
          messageFromCource: args.messageFromCource,
        ),
        settings: data,
      );
    },
    _i32.ExploreAllRecipesView: (data) {
      final args = data.getArgs<ExploreAllRecipesViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i32.ExploreAllRecipesView(key: args.key, recipes: args.recipes),
        settings: data,
      );
    },
    _i33.ViewAllDraftsView: (data) {
      final args = data.getArgs<ViewAllDraftsViewArguments>(
        orElse: () => const ViewAllDraftsViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i33.ViewAllDraftsView(key: args.key),
        settings: data,
      );
    },
    _i34.SearchView: (data) {
      final args = data.getArgs<SearchViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i34.SearchView(
          key: args.key,
          recipeModel: args.recipeModel,
          chefList: args.chefList,
          selectedTagsCount: args.selectedTagsCount,
        ),
        settings: data,
      );
    },
    _i35.CullinarySavedrecipesView: (data) {
      final args = data.getArgs<CullinarySavedrecipesViewArguments>(
        orElse: () => const CullinarySavedrecipesViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i35.CullinarySavedrecipesView(key: args.key),
        settings: data,
      );
    },
    _i36.PrivateRecipesView: (data) {
      final args = data.getArgs<PrivateRecipesViewArguments>(
        orElse: () => const PrivateRecipesViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i36.PrivateRecipesView(key: args.key),
        settings: data,
      );
    },
    _i37.ShoppingListView: (data) {
      final args = data.getArgs<ShoppingListViewArguments>(
        orElse: () => const ShoppingListViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i37.ShoppingListView(key: args.key),
        settings: data,
      );
    },
    _i38.FeedbackView: (data) {
      final args = data.getArgs<FeedbackViewArguments>(
        orElse: () => const FeedbackViewArguments(),
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i38.FeedbackView(key: args.key),
        settings: data,
      );
    },
    _i39.ProfileShareView: (data) {
      final args = data.getArgs<ProfileShareViewArguments>(nullOk: false);
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i39.ProfileShareView(
          key: args.key,
          image: args.image,
          type: args.type,
        ),
        settings: data,
      );
    },
    _i40.ShareRecipeToSailingCheffUserView: (data) {
      final args = data.getArgs<ShareRecipeToSailingCheffUserViewArguments>(
        nullOk: false,
      );
      return _i41.MaterialPageRoute<dynamic>(
        builder: (context) => _i40.ShareRecipeToSailingCheffUserView(
          link: args.link,
          key: args.key,
        ),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class StartupViewArguments {
  const StartupViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant StartupViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class OnboardingViewArguments {
  const OnboardingViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant OnboardingViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class SignUpViewArguments {
  const SignUpViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant SignUpViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class LoginViewArguments {
  const LoginViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant LoginViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class UserDetailsViewArguments {
  const UserDetailsViewArguments({this.key, required this.userRole});

  final _i42.Key? key;

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

class BottomNavBarViewArguments {
  const BottomNavBarViewArguments({this.index, this.key});

  final int? index;

  final _i42.Key? key;

  @override
  String toString() {
    return '{"index": "$index", "key": "$key"}';
  }

  @override
  bool operator ==(covariant BottomNavBarViewArguments other) {
    if (identical(this, other)) return true;
    return other.index == index && other.key == key;
  }

  @override
  int get hashCode {
    return index.hashCode ^ key.hashCode;
  }
}

class SavedRecipesViewArguments {
  const SavedRecipesViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant SavedRecipesViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ProfileViewArguments {
  const ProfileViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class SettingsViewArguments {
  const SettingsViewArguments({this.key, this.isCurrentUser, this.uid});

  final _i42.Key? key;

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

class FilterViewArguments {
  const FilterViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant FilterViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class IndexViewArguments {
  const IndexViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant IndexViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class AddRecipeViewArguments {
  const AddRecipeViewArguments({this.drafts, this.key});

  final _i43.RecipeModel? drafts;

  final _i42.Key? key;

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

class ComingsoonViewArguments {
  const ComingsoonViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ComingsoonViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class RecipeListPageViewArguments {
  const RecipeListPageViewArguments({this.key, required this.isFromDraft});

  final _i42.Key? key;

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

class PinDropMapViewArguments {
  const PinDropMapViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant PinDropMapViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class FollowingListViewArguments {
  const FollowingListViewArguments({
    this.key,
    required this.user,
    required this.isfromFollowing,
  });

  final _i42.Key? key;

  final _i44.UserModel user;

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

  final _i43.RecipeModel recipeModel;

  final List<_i45.XFile> selectedImages;

  final List<String> draftUrls;

  final _i42.Key? key;

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

class BottomBarGuestViewArguments {
  const BottomBarGuestViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant BottomBarGuestViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class SavedRecipeDetailsViewArguments {
  const SavedRecipeDetailsViewArguments({
    this.key,
    required this.recipeModel,
    required this.isFromPrivateProfile,
    required this.randomRecipeList,
  });

  final _i42.Key? key;

  final _i43.RecipeModel recipeModel;

  final bool isFromPrivateProfile;

  final List<_i43.RecipeModel> randomRecipeList;

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
  const ChefProfileViewArguments({required this.user, this.key});

  final _i44.UserModel user;

  final _i42.Key? key;

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

class ChatListViewArguments {
  const ChatListViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ChatListViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class EditProfileViewArguments {
  const EditProfileViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant EditProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class VideoPlayerViewArguments {
  const VideoPlayerViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant VideoPlayerViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class AllChefsViewArguments {
  const AllChefsViewArguments({this.key, required this.chefList});

  final _i42.Key? key;

  final List<_i44.UserModel> chefList;

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

class ForgetPasswordViewArguments {
  const ForgetPasswordViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ForgetPasswordViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class BlockedAccountsViewArguments {
  const BlockedAccountsViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant BlockedAccountsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class BecomechefViewArguments {
  const BecomechefViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant BecomechefViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class PrivacyPolicyViewArguments {
  const PrivacyPolicyViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant PrivacyPolicyViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class CulineryschoolviewallViewArguments {
  const CulineryschoolviewallViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant CulineryschoolviewallViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ChatViewArguments {
  const ChatViewArguments({
    required this.receiver,
    required this.conversationId,
    this.key,
    required this.messageFromCource,
  });

  final _i44.UserModel receiver;

  final String conversationId;

  final _i42.Key? key;

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
  const ExploreAllRecipesViewArguments({this.key, required this.recipes});

  final _i42.Key? key;

  final List<_i43.RecipeModel> recipes;

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

class ViewAllDraftsViewArguments {
  const ViewAllDraftsViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ViewAllDraftsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class SearchViewArguments {
  const SearchViewArguments({
    this.key,
    required this.recipeModel,
    required this.chefList,
    required this.selectedTagsCount,
  });

  final _i42.Key? key;

  final List<_i43.RecipeModel> recipeModel;

  final List<_i44.UserModel> chefList;

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

class CullinarySavedrecipesViewArguments {
  const CullinarySavedrecipesViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant CullinarySavedrecipesViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class PrivateRecipesViewArguments {
  const PrivateRecipesViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant PrivateRecipesViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ShoppingListViewArguments {
  const ShoppingListViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ShoppingListViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class FeedbackViewArguments {
  const FeedbackViewArguments({this.key});

  final _i42.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant FeedbackViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ProfileShareViewArguments {
  const ProfileShareViewArguments({
    this.key,
    required this.image,
    required this.type,
  });

  final _i42.Key? key;

  final String image;

  final String type;

  @override
  String toString() {
    return '{"key": "$key", "image": "$image", "type": "$type"}';
  }

  @override
  bool operator ==(covariant ProfileShareViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.image == image && other.type == type;
  }

  @override
  int get hashCode {
    return key.hashCode ^ image.hashCode ^ type.hashCode;
  }
}

class ShareRecipeToSailingCheffUserViewArguments {
  const ShareRecipeToSailingCheffUserViewArguments({
    required this.link,
    this.key,
  });

  final Uri link;

  final _i42.Key? key;

  @override
  String toString() {
    return '{"link": "$link", "key": "$key"}';
  }

  @override
  bool operator ==(covariant ShareRecipeToSailingCheffUserViewArguments other) {
    if (identical(this, other)) return true;
    return other.link == link && other.key == key;
  }

  @override
  int get hashCode {
    return link.hashCode ^ key.hashCode;
  }
}

extension NavigatorStateExtension on _i46.NavigationService {
  Future<dynamic> navigateToStartupView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.startupView,
      arguments: StartupViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToOnboardingView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.onboardingView,
      arguments: OnboardingViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToSignUpView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.signUpView,
      arguments: SignUpViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToLoginView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.loginView,
      arguments: LoginViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToUserDetailsView({
    _i42.Key? key,
    required String userRole,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.userDetailsView,
      arguments: UserDetailsViewArguments(key: key, userRole: userRole),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToBottomNavBarView({
    int? index,
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.bottomNavBarView,
      arguments: BottomNavBarViewArguments(index: index, key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToSavedRecipesView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.savedRecipesView,
      arguments: SavedRecipesViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToProfileView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.profileView,
      arguments: ProfileViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToSettingsView({
    _i42.Key? key,
    bool? isCurrentUser,
    String? uid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.settingsView,
      arguments: SettingsViewArguments(
        key: key,
        isCurrentUser: isCurrentUser,
        uid: uid,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToFilterView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.filterView,
      arguments: FilterViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToIndexView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.indexView,
      arguments: IndexViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToAddRecipeView({
    _i43.RecipeModel? drafts,
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.addRecipeView,
      arguments: AddRecipeViewArguments(drafts: drafts, key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToComingsoonView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.comingsoonView,
      arguments: ComingsoonViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToRecipeListPageView({
    _i42.Key? key,
    required bool isFromDraft,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.recipeListPageView,
      arguments: RecipeListPageViewArguments(
        key: key,
        isFromDraft: isFromDraft,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToPinDropMapView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.pinDropMapView,
      arguments: PinDropMapViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToFollowingListView({
    _i42.Key? key,
    required _i44.UserModel user,
    required bool isfromFollowing,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.followingListView,
      arguments: FollowingListViewArguments(
        key: key,
        user: user,
        isfromFollowing: isfromFollowing,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToRecipeViewView({
    required _i43.RecipeModel recipeModel,
    required List<_i45.XFile> selectedImages,
    required List<String> draftUrls,
    _i42.Key? key,
    List<double>? waveFormData,
    String? path,
    required bool isFromDraft,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.recipeViewView,
      arguments: RecipeViewViewArguments(
        recipeModel: recipeModel,
        selectedImages: selectedImages,
        draftUrls: draftUrls,
        key: key,
        waveFormData: waveFormData,
        path: path,
        isFromDraft: isFromDraft,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToBottomBarGuestView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.bottomBarGuestView,
      arguments: BottomBarGuestViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToSavedRecipeDetailsView({
    _i42.Key? key,
    required _i43.RecipeModel recipeModel,
    required bool isFromPrivateProfile,
    required List<_i43.RecipeModel> randomRecipeList,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.savedRecipeDetailsView,
      arguments: SavedRecipeDetailsViewArguments(
        key: key,
        recipeModel: recipeModel,
        isFromPrivateProfile: isFromPrivateProfile,
        randomRecipeList: randomRecipeList,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToChefProfileView({
    required _i44.UserModel user,
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.chefProfileView,
      arguments: ChefProfileViewArguments(user: user, key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToChatListView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.chatListView,
      arguments: ChatListViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToEditProfileView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.editProfileView,
      arguments: EditProfileViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToVideoPlayerView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.videoPlayerView,
      arguments: VideoPlayerViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToAllChefsView({
    _i42.Key? key,
    required List<_i44.UserModel> chefList,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.allChefsView,
      arguments: AllChefsViewArguments(key: key, chefList: chefList),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToForgetPasswordView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.forgetPasswordView,
      arguments: ForgetPasswordViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToBlockedAccountsView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.blockedAccountsView,
      arguments: BlockedAccountsViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToBecomechefView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.becomechefView,
      arguments: BecomechefViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToPrivacyPolicyView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.privacyPolicyView,
      arguments: PrivacyPolicyViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToCulineryschoolviewallView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.culineryschoolviewallView,
      arguments: CulineryschoolviewallViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToChatView({
    required _i44.UserModel receiver,
    required String conversationId,
    _i42.Key? key,
    required String? messageFromCource,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.chatView,
      arguments: ChatViewArguments(
        receiver: receiver,
        conversationId: conversationId,
        key: key,
        messageFromCource: messageFromCource,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToExploreAllRecipesView({
    _i42.Key? key,
    required List<_i43.RecipeModel> recipes,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.exploreAllRecipesView,
      arguments: ExploreAllRecipesViewArguments(key: key, recipes: recipes),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToViewAllDraftsView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.viewAllDraftsView,
      arguments: ViewAllDraftsViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToSearchView({
    _i42.Key? key,
    required List<_i43.RecipeModel> recipeModel,
    required List<_i44.UserModel> chefList,
    required int selectedTagsCount,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.searchView,
      arguments: SearchViewArguments(
        key: key,
        recipeModel: recipeModel,
        chefList: chefList,
        selectedTagsCount: selectedTagsCount,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToCullinarySavedrecipesView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.cullinarySavedrecipesView,
      arguments: CullinarySavedrecipesViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToPrivateRecipesView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.privateRecipesView,
      arguments: PrivateRecipesViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToShoppingListView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.shoppingListView,
      arguments: ShoppingListViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToFeedbackView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.feedbackView,
      arguments: FeedbackViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToProfileShareView({
    _i42.Key? key,
    required String image,
    required String type,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.profileShareView,
      arguments: ProfileShareViewArguments(key: key, image: image, type: type),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToShareRecipeToSailingCheffUserView({
    required Uri link,
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.shareRecipeToSailingCheffUserView,
      arguments: ShareRecipeToSailingCheffUserViewArguments(
        link: link,
        key: key,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithStartupView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.startupView,
      arguments: StartupViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithOnboardingView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.onboardingView,
      arguments: OnboardingViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithSignUpView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.signUpView,
      arguments: SignUpViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithLoginView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.loginView,
      arguments: LoginViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithUserDetailsView({
    _i42.Key? key,
    required String userRole,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.userDetailsView,
      arguments: UserDetailsViewArguments(key: key, userRole: userRole),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithBottomNavBarView({
    int? index,
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.bottomNavBarView,
      arguments: BottomNavBarViewArguments(index: index, key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithSavedRecipesView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.savedRecipesView,
      arguments: SavedRecipesViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithProfileView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.profileView,
      arguments: ProfileViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithSettingsView({
    _i42.Key? key,
    bool? isCurrentUser,
    String? uid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.settingsView,
      arguments: SettingsViewArguments(
        key: key,
        isCurrentUser: isCurrentUser,
        uid: uid,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithFilterView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.filterView,
      arguments: FilterViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithIndexView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.indexView,
      arguments: IndexViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithAddRecipeView({
    _i43.RecipeModel? drafts,
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.addRecipeView,
      arguments: AddRecipeViewArguments(drafts: drafts, key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithComingsoonView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.comingsoonView,
      arguments: ComingsoonViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithRecipeListPageView({
    _i42.Key? key,
    required bool isFromDraft,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.recipeListPageView,
      arguments: RecipeListPageViewArguments(
        key: key,
        isFromDraft: isFromDraft,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithPinDropMapView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.pinDropMapView,
      arguments: PinDropMapViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithFollowingListView({
    _i42.Key? key,
    required _i44.UserModel user,
    required bool isfromFollowing,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.followingListView,
      arguments: FollowingListViewArguments(
        key: key,
        user: user,
        isfromFollowing: isfromFollowing,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithRecipeViewView({
    required _i43.RecipeModel recipeModel,
    required List<_i45.XFile> selectedImages,
    required List<String> draftUrls,
    _i42.Key? key,
    List<double>? waveFormData,
    String? path,
    required bool isFromDraft,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.recipeViewView,
      arguments: RecipeViewViewArguments(
        recipeModel: recipeModel,
        selectedImages: selectedImages,
        draftUrls: draftUrls,
        key: key,
        waveFormData: waveFormData,
        path: path,
        isFromDraft: isFromDraft,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithBottomBarGuestView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.bottomBarGuestView,
      arguments: BottomBarGuestViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithSavedRecipeDetailsView({
    _i42.Key? key,
    required _i43.RecipeModel recipeModel,
    required bool isFromPrivateProfile,
    required List<_i43.RecipeModel> randomRecipeList,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.savedRecipeDetailsView,
      arguments: SavedRecipeDetailsViewArguments(
        key: key,
        recipeModel: recipeModel,
        isFromPrivateProfile: isFromPrivateProfile,
        randomRecipeList: randomRecipeList,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithChefProfileView({
    required _i44.UserModel user,
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.chefProfileView,
      arguments: ChefProfileViewArguments(user: user, key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithChatListView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.chatListView,
      arguments: ChatListViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithEditProfileView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.editProfileView,
      arguments: EditProfileViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithVideoPlayerView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.videoPlayerView,
      arguments: VideoPlayerViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithAllChefsView({
    _i42.Key? key,
    required List<_i44.UserModel> chefList,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.allChefsView,
      arguments: AllChefsViewArguments(key: key, chefList: chefList),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithForgetPasswordView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.forgetPasswordView,
      arguments: ForgetPasswordViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithBlockedAccountsView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.blockedAccountsView,
      arguments: BlockedAccountsViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithBecomechefView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.becomechefView,
      arguments: BecomechefViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithPrivacyPolicyView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.privacyPolicyView,
      arguments: PrivacyPolicyViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithCulineryschoolviewallView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.culineryschoolviewallView,
      arguments: CulineryschoolviewallViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithChatView({
    required _i44.UserModel receiver,
    required String conversationId,
    _i42.Key? key,
    required String? messageFromCource,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.chatView,
      arguments: ChatViewArguments(
        receiver: receiver,
        conversationId: conversationId,
        key: key,
        messageFromCource: messageFromCource,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithExploreAllRecipesView({
    _i42.Key? key,
    required List<_i43.RecipeModel> recipes,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.exploreAllRecipesView,
      arguments: ExploreAllRecipesViewArguments(key: key, recipes: recipes),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithViewAllDraftsView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.viewAllDraftsView,
      arguments: ViewAllDraftsViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithSearchView({
    _i42.Key? key,
    required List<_i43.RecipeModel> recipeModel,
    required List<_i44.UserModel> chefList,
    required int selectedTagsCount,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.searchView,
      arguments: SearchViewArguments(
        key: key,
        recipeModel: recipeModel,
        chefList: chefList,
        selectedTagsCount: selectedTagsCount,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithCullinarySavedrecipesView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.cullinarySavedrecipesView,
      arguments: CullinarySavedrecipesViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithPrivateRecipesView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.privateRecipesView,
      arguments: PrivateRecipesViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithShoppingListView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.shoppingListView,
      arguments: ShoppingListViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithFeedbackView({
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.feedbackView,
      arguments: FeedbackViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithProfileShareView({
    _i42.Key? key,
    required String image,
    required String type,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.profileShareView,
      arguments: ProfileShareViewArguments(key: key, image: image, type: type),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithShareRecipeToSailingCheffUserView({
    required Uri link,
    _i42.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.shareRecipeToSailingCheffUserView,
      arguments: ShareRecipeToSailingCheffUserViewArguments(
        link: link,
        key: key,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }
}
