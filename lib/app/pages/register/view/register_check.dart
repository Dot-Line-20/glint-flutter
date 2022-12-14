import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/pages/register/controller.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/constant.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class RegisterCheckPage extends GetView<RegisterPageController> {
  const RegisterCheckPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
 
        title: const Text("본인 인증"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 70),
                  const Text("이메일로 온 4자리 숫자를 입력해주세요.", style: AppTextTheme.T3),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 300,
                    child: PinCodeTextField(
                      autoFocus: true,
                      controller: controller.pinController,
                      appContext: context,
                      length: 4,
                      onChanged: (_) {},
                      onCompleted: (_) {},
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: 60,
                          fieldWidth: 55,
                          selectedColor: AppColorTheme.Gray1,
                          activeColor: AppColorTheme.Gray1,
                          inactiveColor: AppColorTheme.Gray2),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            controller.obx(
              (_) => Obx(
                () => GTKeyboardReactiveButton(
                  disabled: !controller.passwordInputValidity,
                  onTap: controller.moveToForthPage,
                  child: Text(
                    "다음",
                    style: AppTextTheme.T4.copyWith(color: AppColorTheme.white),
                  ),
                ),
              ),
              onLoading: const GTKeyboardReactiveButton(
                disabled: false,
                child: SizedBox(height: 20, width: 20, child: LOADINGINDICATOR),
              ),
            ),
            const SizedBox(height: 18),
            GestureDetector(
              onTap: controller.moveToChangeEmail,
              child: const Text(
                "이메일이 오지 않았어요 > ",
                style: AppTextTheme.Main,
              ),
            )
          ],
        ),
      )),
    );
  }
}
