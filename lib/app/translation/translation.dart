import 'dart:ui';

import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'enter_mail': 'Enter your email',
        },
        'ur_PK': {
          'enter_mail': 'اپنا ای میل درج کریں۔',
        }
      };
}

//Get.updateLocale(const Locale('ko', 'KR'))

abstract class GetCurrentLocale {
  static final currentDeviceLocale = Get.deviceLocale;
  static final currentLocale = Get.locale;
  static final currentSystemLocale = window.locale;
  static const fallBackLocale = Locale("en", "US");
}
