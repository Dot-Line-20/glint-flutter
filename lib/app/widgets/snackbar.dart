import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FGBPSnackBar {
  static void open(String title,
      {Color backgroundColor = AppColorTheme.black,
      Color textColor = AppColorTheme.black}) {
    Get.rawSnackbar(
      titleText: Text(title,
          style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              height: 1,
              color: textColor)),
      messageText: Container(),
      backgroundColor: backgroundColor,
      borderRadius: 12,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      animationDuration: const Duration(milliseconds: 800),
    );
  }

  static void openOne(String title, String one) {
    Get.rawSnackbar(
        onTap: (_) {
          Get.back();
        },
        titleText: Text(title, style: AppTextTheme.boldGray1_16),
        messageText: Text(one, style: AppTextTheme.semiboldGrey1_16),
        isDismissible: true,
        backgroundColor: AppColorTheme.white,
        mainButton: FGBPSmallTextButton(text: "꿋"));
  }
}
