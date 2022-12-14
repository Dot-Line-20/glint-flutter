import 'package:flutter/foundation.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/data/initalize.dart';
import 'package:glint/app/routes/pages.dart';
import 'package:glint/app/routes/route.dart';
import 'package:glint/app/translation/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await AppInitalizer().init();
  FlutterNativeSplash.remove();

  // Do Firebase Initial Settings With Firebase CLI
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Get.config();
  runApp(
    FlutterWebFrame(
      builder: (_) => GetMaterialApp(
        initialRoute: Routes.home,
        getPages: AppPages.pages,
        theme: ThemeData(
          fontFamily: "Pretendard",
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
            foregroundColor: Colors.black,
            backgroundColor: Colors.transparent,
            titleTextStyle: AppTextTheme.T4,
          ),
        ),
        locale: GetCurrentLocale.currentDeviceLocale,
        fallbackLocale: GetCurrentLocale.fallBackLocale,
      ),
      maximumSize: Size(500, Get.height),
      enabled: kIsWeb, // default is enable, when disable content is full size
    ),
  );
}
