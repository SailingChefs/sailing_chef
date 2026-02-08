// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/services/add_recipe_session_service.dart';
import 'package:sailing_chefs/services/auth_service.dart';
import 'package:sailing_chefs/services/bitmap_image_service.dart';
import 'package:sailing_chefs/services/block_user_service.dart';
import 'package:sailing_chefs/services/chef_service.dart';
import 'package:sailing_chefs/services/comment_service.dart';
import 'package:sailing_chefs/services/conversation_service.dart';
import 'package:sailing_chefs/services/cullinaryschool_service.dart';
import 'package:sailing_chefs/services/filter_service.dart';
import 'package:sailing_chefs/services/follow_service.dart';
import 'package:sailing_chefs/services/location_service.dart';
import 'package:sailing_chefs/services/pin_drop_service.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:sailing_chefs/services/saved_recipe_service.dart';
import 'package:sailing_chefs/services/search_service.dart';
import 'package:sailing_chefs/services/shopping_list_service.dart';
import 'package:sailing_chefs/services/user_services.dart';
import 'package:sailing_chefs/services/userdata_service_service.dart';
import 'package:sailing_chefs/ui/views/bottom_nav_bar/bottom_nav_bar_viewmodel.dart';
import 'package:stacked_shared/stacked_shared.dart';

final locator = StackedLocator.instance;

void setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) {
// Register environments
  locator.registerEnvironment(environment: environment, environmentFilter: environmentFilter);

  // Register dependencies
  locator.registerLazySingleton(BottomSheetService.new);
  locator.registerLazySingleton(DialogService.new);
  locator.registerLazySingleton(NavigationService.new);
  locator.registerLazySingleton(UserServices.new);
  locator.registerLazySingleton(AuthService.new);
  locator.registerLazySingleton(RecipeService.new);
  locator.registerLazySingleton(LocationService.new);
  locator.registerLazySingleton(ConversationService.new);
  locator.registerLazySingleton(ChefService.new);
  locator.registerLazySingleton(ShoppingListService.new);
  locator.registerLazySingleton(SnackbarService.new);
  locator.registerLazySingleton(UserdataServiceService.new);
  locator.registerLazySingleton(AddRecipeSessionService.new);
  locator.registerLazySingleton(BottomNavBarViewModel.new);
  locator.registerLazySingleton(CommentService.new);
  locator.registerLazySingleton(SavedRecipeService.new);
  locator.registerLazySingleton(BlockUserService.new);
  locator.registerLazySingleton(BitmapImageService.new);
  locator.registerLazySingleton(FollowService.new);
  locator.registerLazySingleton(SearchService.new);
  locator.registerLazySingleton(CullinaryschoolService.new);
  locator.registerLazySingleton(PinDropService.new);
  locator.registerLazySingleton(FilterService.new);
}
