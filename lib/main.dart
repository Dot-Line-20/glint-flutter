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
    GetMaterialApp(
      initialRoute: Routes.login,
      getPages: AppPages.pages,
      theme: ThemeData(fontFamily: "Pretendard"),
      locale: GetCurrentLocale.currentDeviceLocale,
      fallbackLocale: GetCurrentLocale.fallBackLocale,
    ),
  );
}
