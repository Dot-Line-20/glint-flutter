import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/pages/schedule/binding.dart';
import 'package:glint/app/pages/schedule/page.dart';
import 'package:glint/app/pages/sns/binding.dart';
import 'package:glint/app/pages/sns/page.dart';
import 'package:glint/app/routes/route.dart';

class HomePageController extends GetxController {
  final _navigatorKey = Random().nextInt(65535);
  late final navigatorKey = Get.nestedKey(_navigatorKey);
  final _pageIndex = 0.obs;
  int get pageIndex => _pageIndex.value;
  final _pages = [
    Routes.sns,
    Routes.schedule,
  ];

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.sns:
        return GetPageRoute(
          transition: Transition.noTransition,
          settings: settings,
          page: () => const SnsPage(),
          binding: SnsPageBinding(),
        );
      case Routes.schedule:
        return GetPageRoute(
          transition: Transition.noTransition,
          settings: settings,
          page: () => const SchedulePage(),
          binding: SchedulePageBinding(),
        );

      default:
        return GetPageRoute(settings: settings, page: () => Container());
    }
  }

  void changePage(int index) {
    if (_pageIndex.value == index) return;
    if (_pages[index] == '') return;
    _pageIndex(index);
    Get.offAllNamed(_pages[index], id: _navigatorKey);
  }
}
