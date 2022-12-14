import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/pages/home/controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
          () => IndexedStack(
              index: controller.pageIndex, children: controller.pages),
        ),
        bottomNavigationBar: Obx(() {
          if (controller.hideBottomBar) return const SizedBox();
          return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black.withAlpha(50),
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 0.75))
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
              child: BottomNavigationBar(
                elevation: 10,
                backgroundColor: AppColorTheme.white,
                type: BottomNavigationBarType.fixed,
                currentIndex: controller.pageIndex,
                showSelectedLabels: true,
                selectedLabelStyle:
                    AppTextTheme.T7.copyWith(color: AppColorTheme.Blue),
                unselectedLabelStyle:
                    AppTextTheme.T7.copyWith(color: AppColorTheme.Gray3),
                selectedItemColor: AppColorTheme.BUTTON1,
                onTap: controller.changePage,
                items: [
                  _bottomNavItem("assets/images/main", "홈"),
                  _bottomNavItem("assets/images/main", "일정"),
                  _bottomNavItem("assets/images/user", "마이"),
                ],
              ),
            ),
          );
        }));
  }

  BottomNavigationBarItem _bottomNavItem(String imageUrl, String label) {
    return BottomNavigationBarItem(
        icon: SvgPicture.asset("$imageUrl.svg"),
        activeIcon: SvgPicture.asset("${imageUrl}_color.svg"),
        label: label);
  }
}
