import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/data/service/auth/service.dart';
import 'package:glint/app/routes/route.dart';
import 'package:glint/app/widgets/button.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "설정",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GTMediumTextButton(
                  text: "로그아웃",
                  onTap: () {
                    if (GetPlatform.isIOS) {
                      showCupertinoDialog(
                        context: Get.overlayContext!,
                        builder: (BuildContext context) => CupertinoAlertDialog(
                          content: const Text('정말 로그아웃 할까요?'),
                          actions: <CupertinoDialogAction>[
                            CupertinoDialogAction(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('취소'),
                            ),
                            CupertinoDialogAction(
                              isDestructiveAction: true,
                              onPressed: () {
                                Get.find<AuthService>().logout();
                                Get.offAllNamed(Routes.login);
                              },
                              child: const Text('로그아웃'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      showDialog<String>(
                        context: Get.overlayContext!,
                        builder: (BuildContext context) => AlertDialog(
                          content: const Text('정말 로그아웃 할까요?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('취소'),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.find<AuthService>().logout();
                                Get.offAllNamed(Routes.login);
                              },
                              child: const Text('로그아웃',
                                  style:
                                      TextStyle(color: AppColorTheme.Sys_Red)),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
