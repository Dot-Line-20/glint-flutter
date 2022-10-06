import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/pages/register/controller.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/textfield.dart';

class RegisterInitPage extends GetView<RegisterPageController> {
  const RegisterInitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColorTheme.black,
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("회원가입", style: AppTextTheme.boldHGray1_24),
                  const SizedBox(height: 8),
                  const Text("GLINT를 시작해보아요!",
                      style: AppTextTheme.boldGray2_14),
                  const SizedBox(height: 50),
                  Form(
                    key: controller.formKey,
                    child: FocusScope(
                        node: controller.formFocusScopeNode,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("이메일",
                                  style: AppTextTheme.boldGray3_14),
                              GTTextFormField(
                                enableInteractiveSelection: false,
                                controller: controller.emailTextController,
                              ),
                              const SizedBox(height: 50),
                              const Text("비밀번호",
                                  style: AppTextTheme.boldGray3_14),
                              GTTextFormField(
                                enableInteractiveSelection: false,
                                isPassword: true,
                                controller: controller.passwordTextController,
                              ),
                              const SizedBox(height: 50),
                              const Text("이름  ",
                                  style: AppTextTheme.boldGray3_14),
                              GTTextFormField(
                                enableInteractiveSelection: false,
                                controller: controller.nameTextController,
                              ),
                              const SizedBox(height: 50),
                              const Text("생년월일",
                                  style: AppTextTheme.boldGray3_14),
                              GTTextFormField(
                                readOnly: true,
                                onTap: controller.pickDateTime,
                                textInputType: TextInputType.datetime,
                                enableInteractiveSelection: false,
                                controller: controller.birthDayController,
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            controller.obx(
              (_) => Obx(
                () => GTKeyboardReactiveButton(
                  disabled: !controller.initInputValidity,
                  onTap: controller.initInputValidity
                      ? controller.registerUser
                      : null,
                  child: const Text(
                    "다음",
                    style: AppTextTheme.boldWhite_18,
                  ),
                ),
              ),
              onLoading: const GTKeyboardReactiveButton(
                disabled: false,
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: AppColorTheme.white,
                    strokeWidth: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
