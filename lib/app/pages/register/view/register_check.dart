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
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("본인 인증", style: AppTextTheme.boldHGray1_24),
                  const SizedBox(height: 8),
                  const Text("비밀번호는 8자리 이상, 특수문자를 포함해야해요",
                      style: AppTextTheme.boldGray2_14),
                  const SizedBox(height: 50),
                  Text(
                    controller.emailText.value ?? "",
                    style: AppTextTheme.boldBlue_24,
                  ),
                  PinCodeTextField(
                    autoFocus: true,
                    controller: controller.pinController,
                    appContext: context,
                    length: 4,
                    onChanged: (_) {},
                    onCompleted: (_) {},
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeColor: Colors.blue,
                        inactiveColor: Colors.grey),
                    keyboardType: TextInputType.number,
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
