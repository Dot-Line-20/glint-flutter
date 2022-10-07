import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/pages/home/controller.dart';
import 'package:glint/app/routes/route.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Navigator(
          key: controller.navigatorKey,
          initialRoute: Routes.sns,
          onGenerateRoute: controller.onGenerateRoute,
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            elevation: 8,
            backgroundColor: AppColorTheme.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.pageIndex,
            showSelectedLabels: true,
            selectedItemColor: AppColorTheme.BUTTON1,
            onTap: controller.changePage,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: AppColorTheme.black,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                    color: AppColorTheme.BUTTON1,
                  ),
                  label: "홈"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: AppColorTheme.black,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                    color: AppColorTheme.BUTTON1,
                  ),
                  label: "일정"),
            ],
          ),
        ));
  }
}
