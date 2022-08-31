import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/pages/register/controller.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/textfield.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class RegisterCheckPage extends GetView<RegisterPageController> {
  const RegisterCheckPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColorTheme.black,
        elevation: 0,
        centerTitle: true,
        title: const Text("본인 인증", style: AppTextTheme.mediumGray1_18),
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
                  const Text("이메일로 온 4자리 숫자를 입력해주세요.",
                      style: AppTextTheme.mediumGray1_20),
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
            const SizedBox(height: 16),
          ],
        ),
      )),
    );
  }
}
