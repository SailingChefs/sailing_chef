import 'package:sailing_chefs/services/auth_service.dart';

import 'package:sailing_chefs/services/bitmap_image_service.dart';
import 'package:sailing_chefs/services/block_user_service.dart';
import 'package:sailing_chefs/services/cullinaryschool_service.dart';

import 'package:sailing_chefs/services/follow_service.dart';
import 'package:sailing_chefs/services/pin_drop_service.dart';
import 'package:sailing_chefs/services/search_service.dart';

import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:sailing_chefs/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:sailing_chefs/ui/views/Messages/chat_view.dart';
import 'package:sailing_chefs/ui/views/bottom_nav_bar/bottom_nav_bar_viewmodel.dart';
import 'package:sailing_chefs/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sailing_chefs/ui/views/onboarding/onboarding_view.dart';
import 'package:sailing_chefs/ui/views/sign_up/sign_up_view.dart';
import 'package:sailing_chefs/ui/views/login/login_view.dart';
import 'package:sailing_chefs/ui/views/user_details/user_details_view.dart';
import 'package:sailing_chefs/ui/views/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/saved_recipes_view.dart';
import 'package:sailing_chefs/ui/views/profile/profile_view.dart';
import 'package:sailing_chefs/ui/views/settings/settings_view.dart';
import 'package:sailing_chefs/ui/views/filter/filter_view.dart';
import 'package:sailing_chefs/ui/views/index/index_view.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_view.dart';
import 'package:sailing_chefs/ui/views/comingsoon/comingsoon_view.dart';
import 'package:sailing_chefs/ui/bottom_sheets/add_ingredients/add_ingredients_sheet.dart';
import 'package:sailing_chefs/ui/bottom_sheets/cooking_instructions/cooking_instructions_sheet.dart';
import 'package:sailing_chefs/ui/dialogs/save_draft_alertbox/save_draft_alertbox_dialog.dart';
import 'package:sailing_chefs/ui/views/recipe_list_page/recipe_list_page_view.dart';
import 'package:sailing_chefs/ui/views/pin_drop_map/pin_drop_map_view.dart';
import 'package:sailing_chefs/ui/views/following_list/following_list_view.dart';
import 'package:sailing_chefs/ui/bottom_sheets/drop_pin_sheet/drop_pin_sheet_sheet.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_view.dart';
import 'package:sailing_chefs/ui/views/bottom_bar_guest/bottom_bar_guest_view.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_view.dart';
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_view.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/location_service.dart';
import 'package:sailing_chefs/ui/views/chat_list/chat_list_view.dart';
import 'package:sailing_chefs/services/conversation_service.dart';
import 'package:sailing_chefs/services/chef_service.dart';
import 'package:sailing_chefs/ui/views/edit_profile/edit_profile_view.dart';
import 'package:sailing_chefs/services/userdata_service_service.dart';
import 'package:sailing_chefs/ui/bottom_sheets/drop_pin_buttons/drop_pin_buttons_sheet.dart';
import 'package:sailing_chefs/ui/dialogs/pindrop_dialoguebox/pindrop_dialoguebox_dialog.dart';
import 'package:sailing_chefs/services/comment_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';

import 'package:sailing_chefs/ui/views/video_player/video_player_view.dart';

import 'package:sailing_chefs/ui/views/all_chefs/all_chefs_view.dart';
import 'package:sailing_chefs/ui/bottom_sheets/other_chef_profile/other_chef_profile_sheet.dart';

import 'package:sailing_chefs/ui/views/forget_password/forget_password_view.dart';
import 'package:sailing_chefs/ui/views/blocked_accounts/blocked_accounts_view.dart';
import 'package:sailing_chefs/ui/views/becomechef/becomechef_view.dart';
import 'package:sailing_chefs/ui/dialogs/delete_account/delete_account_dialog.dart';
import 'package:sailing_chefs/ui/dialogs/block_account/block_account_dialog.dart';
import 'package:sailing_chefs/ui/views/privacy_policy/privacy_policy_view.dart';
import 'package:sailing_chefs/ui/views/culineryschoolviewall/culineryschoolviewall_view.dart';
import 'package:sailing_chefs/ui/bottom_sheets/courses/courses_sheet.dart';
import 'package:sailing_chefs/ui/dialogs/course_saved/course_saved_dialog.dart';
import 'package:sailing_chefs/ui/views/user_chat/user_chat_view.dart';
import 'package:sailing_chefs/ui/views/explore_all_recipes/explore_all_recipes_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView),
    MaterialRoute(page: OnboardingView),
    MaterialRoute(page: SignUpView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: UserDetailsView),
    MaterialRoute(page: BottomNavBarView),
    MaterialRoute(page: SavedRecipesView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: FilterView),
    MaterialRoute(page: IndexView),
    MaterialRoute(page: AddRecipeView),
    MaterialRoute(page: ComingsoonView),
    MaterialRoute(page: RecipeListPageView),
    MaterialRoute(page: PinDropMapView),
    MaterialRoute(page: FollowingListView),
    MaterialRoute(page: RecipeViewView),
    MaterialRoute(page: BottomBarGuestView),
    MaterialRoute(page: SavedRecipeDetailsView),
    MaterialRoute(page: ChefProfileView),
    MaterialRoute(page: ChatListView),
    MaterialRoute(page: EditProfileView),

    MaterialRoute(page: VideoPlayerView),

    MaterialRoute(page: AllChefsView),

    MaterialRoute(page: ForgetPasswordView),
    MaterialRoute(page: BlockedAccountsView),
    MaterialRoute(page: BecomechefView),
    MaterialRoute(page: PrivacyPolicyView),
    MaterialRoute(page: CulineryschoolviewallView),
    MaterialRoute(page: ChatView),
    MaterialRoute(page: UserChatView),
    MaterialRoute(page: ExploreAllRecipesView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: UserServices),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: RecipeService),
    LazySingleton(classType: LocationService),
    LazySingleton(classType: ConversationService),
    LazySingleton(classType: ChefService),

    LazySingleton(classType: UserdataServiceService),
    LazySingleton(classType: BottomNavBarViewModel),
    LazySingleton(classType: CommentService),
    LazySingleton(classType: SavedRecipeService),
    LazySingleton(classType: BlockUserService),

    LazySingleton(classType: BitmapImageService),
    LazySingleton(classType: FollowService),
    LazySingleton(classType: SearchService),
    LazySingleton(classType: CullinaryschoolService),
    LazySingleton(classType: PinDropService),

// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: AddIngredientsSheet),
    StackedBottomsheet(classType: CookingInstructionsSheet),
    StackedBottomsheet(classType: DropPinSheetSheet),
    StackedBottomsheet(classType: DropPinButtonsSheet),
    StackedBottomsheet(classType: OtherChefProfileSheet),
    StackedBottomsheet(classType: CoursesSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: SaveDraftAlertboxDialog),
    StackedDialog(classType: PindropDialogueboxDialog),
    StackedDialog(classType: DeleteAccountDialog),
    StackedDialog(classType: BlockAccountDialog),
    StackedDialog(classType: CourseSavedDialog),
// @stacked-dialog
  ],
)
class App {}
