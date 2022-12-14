import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/pages/register/controller.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/constant.dart';

class EmailCheckPage extends GetView<RegisterPageController> {
  const EmailCheckPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("이메일 확인"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(controller.emailText.value ?? "",
                          style: AppTextTheme.Title.copyWith(
                              color: AppColorTheme.Blue)),
                      const SizedBox(height: 20),
                      const Text("이 이메일이 맞나요? 아니라면 변경해주세요",
                          style: AppTextTheme.T5),
                      const SizedBox(height: 50),
                      GestureDetector(
                        onTap: controller.moveToReSecondPage,
                        child: const Text(
                          "이메일 변경 > ",
                          style: AppTextTheme.T4,
                        ),
                      ),
                    ],
                  ),
                ),
                controller.obx(
                  (_) => GTKeyboardReactiveButton(
                    disabled: true,
                    onTap: controller.moveToThirdPage,
                    child: Text(
                      "다시 인증하기",
                      style:
                          AppTextTheme.T4.copyWith(color: AppColorTheme.white),
                    ),
                  ),
                  onLoading: const GTKeyboardReactiveButton(
                    disabled: false,
                    child: SizedBox(
                        height: 20, width: 20, child: LOADINGINDICATOR),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
