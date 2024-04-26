// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/auth_service.dart';
import '../services/bitmap_image_service.dart';
import '../services/chef_service.dart';
import '../services/comment_service.dart';
import '../services/conversation_service.dart';
import '../services/dishes_service.dart';
import '../services/follow_service.dart';
import '../services/location_service.dart';
import '../services/pin_drop_service.dart';
import '../services/recipe_service.dart';
import '../services/saved_recipe_service.dart';
import '../services/search_service.dart';
import '../services/user_services.dart';
import '../services/userdata_service_service.dart';
import '../ui/views/bottom_nav_bar/bottom_nav_bar_viewmodel.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => UserServices());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => RecipeService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => ConversationService());
  locator.registerLazySingleton(() => ChefService());
  locator.registerLazySingleton(() => DishesService());
  locator.registerLazySingleton(() => UserdataServiceService());
  locator.registerLazySingleton(() => BottomNavBarViewModel());
  locator.registerLazySingleton(() => CommentService());
  locator.registerLazySingleton(() => SavedRecipeService());

  locator.registerLazySingleton(() => PinDropService());


  locator.registerLazySingleton(() => BitmapImageService());
  locator.registerLazySingleton(() => PinDropService());

  locator.registerLazySingleton(() => FollowService());
  locator.registerLazySingleton(() => SearchService());


}
