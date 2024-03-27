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
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: SaveDraftAlertboxDialog),
// @stacked-dialog
  ],
)
class App {}
