import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/service/orientation/service.dart';
import 'package:glint/app/pages/schedule/page.dart';
import 'package:glint/app/pages/sns/page.dart';
import 'package:glint/app/pages/user/page.dart';
import 'package:glint/app/routes/route.dart';

class HomePageController extends GetxController {
  final _pageIndex = 0.obs;
  int get pageIndex => _pageIndex.value;

  bool get hideBottomBar => pageIndex == 1 && OrientationService.to.isLandscape;

  final _pages = [
    Routes.sns,
    Routes.schedule,
    Routes.user,
  ];

  List<Widget> pages = [
    SnsPage(),
    SchedulePage(),
    UserPage(),
  ];

  void changePage(int index) {
    if (_pageIndex.value == index) return;
    if (_pages[index] == '') return;
    _pageIndex(index);
    //Get.offAllNamed(_pages[index], id: _navigatorKey);
  }
}
