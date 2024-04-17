import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sailing_chefs/app/app.bottomsheets.dart';
import 'package:sailing_chefs/app/app.dialogs.dart';
import 'package:sailing_chefs/app/app.locator.dart';
import 'package:sailing_chefs/app/app.router.dart';
import 'package:sailing_chefs/firebase_options.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';

import 'core/theme/text_styles.dart';
import 'package:device_preview/device_preview.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupLocator();
  setupDialogUi();

  setupBottomSheetUi();
  EasyLoading.instance
    ..textStyle = globalTextStyle(fontSize: 12, color: Colors.white)
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = kcDarkColor.withOpacity(0.5)
    ..radius = 12
    ..indicatorSize = 30
    ..textColor = kcPrimaryColor
    ..textStyle = globalTextStyle(fontSize: 14)
    ..indicatorColor = kcDarkColor
    ..maskColor = kcDarkColor.withOpacity(0.5)
    ..userInteractions = false
    ..displayDuration = const Duration(seconds: 1)
    ..dismissOnTap = false;
  runApp(
  DevicePreview(
    enabled: kDebugMode,
    builder: (context) => const MainApp(), 
  ));
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
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.startupView,
                  locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
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
            // builder: EasyLoading.init(),
          ),
        ),
      ),
    );
  }
}
