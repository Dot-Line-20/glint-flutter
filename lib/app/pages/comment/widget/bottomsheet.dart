import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';

class CommentBottomSheet {
  void bottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: Get.overlayContext!,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            height: 140,
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: AppColorTheme.Gray3,
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      height: 5,
                      width: 100,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColorTheme.Gray5,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Column(
                              children: [
                                SvgPicture.asset("assets/images/spam.svg"),
                                const Text(
                                  "신고하기",
                                  style: AppTextTheme.mediumRed_12,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
