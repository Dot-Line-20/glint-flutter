import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/pages/register/controller.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/textfield.dart';

class RegisterCreatePage extends GetView<RegisterPageController> {
  const RegisterCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColorTheme.black,
        elevation: 0,
        centerTitle: true,
        title: const Text("프로필 생성", style: AppTextTheme.mediumGray1_18),
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
                  Stack(
                    children: [
                      Image.asset("assets/images/default_profile.png"),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppColorTheme.BUTTON1),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 13),
                            child: Text(
                              "변경",
                              style: AppTextTheme.boldWhite_12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 55),
                  Form(
                    key: controller.thirdFormKey,
                    child: FocusScope(
                        node: controller.formFocusScopeNode,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("닉네임", style: AppTextTheme.boldGray3_14),
                            GTTextFormField(
                              enableInteractiveSelection: false,
                              controller: controller.nicknameTextController,
                            ),
                            const SizedBox(height: 50),
                            const Text("사용자 아이디",
                                style: AppTextTheme.boldGray3_14),
                            GTTextFormField(
                              isPassword: true,
                              enableInteractiveSelection: false,
                              controller: controller.userIdTextController,
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
            controller.obx(
              (_) => Obx(
                () => GTKeyboardReactiveButton(
                  disabled: !controller.passwordInputValidity,
                  child: const Text(
                    "확인",
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
