import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/pages/register/controller.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/constant.dart';
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
        title: const Text("프로필 생성", style: AppTextTheme.T4),
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 13),
                            child: Text(
                              "변경",
                              style: AppTextTheme.T7
                                  .copyWith(color: AppColorTheme.white),
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
                            Text("닉네임",
                                style: AppTextTheme.T6
                                    .copyWith(color: AppColorTheme.Gray3)),
                            GTTextFormField(
                              enableInteractiveSelection: false,
                              controller: controller.nicknameTextController,
                            ),
                            const SizedBox(height: 50),
                            Text("사용자 아이디",
                                style: AppTextTheme.T6
                                    .copyWith(color: AppColorTheme.Gray3)),
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
                  child: Text(
                    "확인",
                    style: AppTextTheme.T4.copyWith(color: AppColorTheme.white),
                  ),
                ),
              ),
              onLoading: const GTKeyboardReactiveButton(
                disabled: false,
                child: SizedBox(height: 20, width: 20, child: LOADINGINDICATOR),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
