import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_cache_manager/media_cache_manager.dart';
import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/app/app.router.dart';
import 'package:sailing_chefs/firebase_options.dart';
import 'package:sailing_chefs/services/bitmap_image_service.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/services/recipe_service.dart';
import 'package:uuid/uuid.dart';
import 'core/theme/text_styles.dart';

Uuid uuid = const Uuid();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupLocator();
  setupDialogUi();
  await MediaCacheManager.instance.init();
  setupBottomSheetUi();
  EasyLoading.instance
    ..textStyle = globalTextStyle(fontSize: 12, color: Colors.white)
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = kcPrimaryColor
    ..radius = 12
    ..indicatorSize = 30
    ..textColor = kcPrimaryColor
    ..textStyle = globalTextStyle(fontSize: 14)
    ..indicatorColor = kcwhitecolor
    ..maskColor = kcBlackColor
    ..userInteractions = false
    ..displayDuration = const Duration(seconds: 1)
    ..dismissOnTap = false;

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    // final PendingDynamicLinkData? data =
    //     await FirebaseDynamicLinks.instance.getInitialLink();
    // if (data != null) {
    //   _handleDynamicLinks(data);
    // }

    FirebaseDynamicLinks.instance.onLink.listen((event) async {
      _handleDynamicLinks(event);
    });

    runApp(const MainApp());
  });
}

void _handleDynamicLinks(PendingDynamicLinkData? dynamicLink) async {
  final Uri? deepLink = dynamicLink?.link;
  if (deepLink != null) {
    log(deepLink.toString());
    _navigateToRecipe(deepLink);
  }
}

List<RecipeModel>? allRecipes;

Future<List<RecipeModel>> getRandomDishes(String currentRecipe) async {
  allRecipes = await recipeService.fetchAllRecipes();
  List<RecipeModel> dishes = List.from(allRecipes!);
  dishes.removeWhere((recipe) => recipe.docId == currentRecipe);

  dishes.shuffle();
  log(dishes.length.toString());

  return dishes.length > 5 ? dishes.sublist(0, 5) : dishes;
}

RecipeService recipeService = locator<RecipeService>();

void _navigateToRecipe(Uri deepLink) async {
  final String? recipeId = deepLink.queryParameters['recipe'];
  getRandomDishes(recipeId!);
  // ignore: unnecessary_null_comparison
  if (recipeId != null) {
    log(recipeId.toString());

    RecipeModel? recipe = await recipeService.fetchRecipeById(recipeId);
    if (recipe != null) {
      NavigationService navigation = locator<NavigationService>();
      navigation.navigateToSavedRecipeDetailsView(
          recipeModel: recipe,
          isFromPrivateProfile: false,
          randomRecipeList: allRecipes!);
    }
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: false,
      splitScreenMode: false,
      useInheritedMediaQuery: true,
      builder: (context, child) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Builder(
          builder: (context) {
            // Initialize BitmapImageService after runApp
            Future.microtask(
                () => locator<BitmapImageService>().initialise(context));
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.startupView,
              onGenerateRoute: StackedRouter().onGenerateRoute,
              navigatorKey: StackedService.navigatorKey,
              theme: ThemeData(
                primaryColor: kcPrimaryColor,
                primarySwatch: primarySwatch,
                fontFamily: 'Inter',
                appBarTheme: AppBarTheme(
                  color: Colors.white,
                  elevation: 0,
                  titleTextStyle: globalTextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              ),
              navigatorObservers: [
                StackedService.routeObserver,
              ],
              builder: EasyLoading.init(),
            );
          },
        ),
      ),
    );
  }
}
