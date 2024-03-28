import 'package:sailing_chefs/services/auth_service.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:sailing_chefs/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:sailing_chefs/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sailing_chefs/ui/views/onboarding/onboarding_view.dart';
import 'package:sailing_chefs/ui/views/sign_up/sign_up_view.dart';
import 'package:sailing_chefs/ui/views/login/login_view.dart';
import 'package:sailing_chefs/ui/views/user_details/user_details_view.dart';
import 'package:sailing_chefs/ui/views/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:sailing_chefs/ui/views/saved_recipes/saved_recipes_view.dart';
import 'package:sailing_chefs/ui/views/chat/chat_view.dart';
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
    MaterialRoute(page: ChatView),
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
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: UserServices),
    LazySingleton(classType: AuthService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: AddIngredientsSheet),
    StackedBottomsheet(classType: CookingInstructionsSheet),
    StackedBottomsheet(classType: DropPinSheetSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: SaveDraftAlertboxDialog),
// @stacked-dialog
  ],
)
class App {}
