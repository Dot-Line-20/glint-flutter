import 'package:firebase_getx_boilerplate/app/data/initalize.dart';
import 'package:firebase_getx_boilerplate/app/routes/pages.dart';
import 'package:firebase_getx_boilerplate/app/routes/route.dart';
import 'package:firebase_getx_boilerplate/app/translation/translation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Do Firebase Initial Settings With Firebase CLI
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppInitalizer().init();
  runApp(GetMaterialApp(
    initialRoute: Routes.home,
    getPages: AppPages.pages,
    theme: ThemeData(fontFamily: "Pretendard"),
    locale: GetCurrentLocale.currentDeviceLocale,
    fallbackLocale: GetCurrentLocale.fallBackLocale,
  ));
}
