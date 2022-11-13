import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/util/constant.dart';
import 'package:glint/app/pages/register/controller.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/constant.dart';
import 'package:glint/app/widgets/textfield.dart';

class RegisterPasswordPage extends GetView<RegisterPageController> {
  const RegisterPasswordPage({Key? key}) : super(key: key);

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
                  const Text("회원가입", style: AppTextTheme.Title),
                  const SizedBox(height: 8),
                  Text("비밀번호는 8자리 이상, 특수문자를 포함해야해요",
                      style:
                          AppTextTheme.T6.copyWith(color: AppColorTheme.Gray2)),
                  const SizedBox(height: 50),
                  Form(
                    key: controller.secondFormKey,
                    child: FocusScope(
                        node: controller.formFocusScopeNode,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("아이디",
                                style: AppTextTheme.T6
                                    .copyWith(color: AppColorTheme.Gray3)),
                            GTTextFormField(
                              enableInteractiveSelection: false,
                              controller: controller.idTextController,
                            ),
                            const SizedBox(height: 50),
                            Obx(
                              () => Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("비밀번호",
                                      style: AppTextTheme.T6.copyWith(
                                          color: AppColorTheme.Gray3)),
                                  GTTextFormField(
                                    enableInteractiveSelection: false,
                                    controller:
                                        controller.passwordTextController,
                                    color: controller.passwordAvailableIsNull
                                        ? AppColorTheme.Gray3
                                        : controller.passwordAvailable
                                            ? AppColorTheme.Sys_Green
                                            : AppColorTheme.Sys_Red,
                                  ),
                                  if (!controller.passwordAvailableIsNull)
                                    const SizedBox(height: 8),
                                  if (!controller.passwordAvailableIsNull)
                                    Text(
                                      controller.guideText.value ?? "",
                                      style: controller.passwordAvailable
                                          ? AppTextTheme.T7.copyWith(
                                              color: AppColorTheme.Sys_Green)
                                          : AppTextTheme.T7.copyWith(
                                              color: AppColorTheme.Sys_Red),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 50),
                            Text("비밀번호 확인",
                                style: AppTextTheme.T6
                                    .copyWith(color: AppColorTheme.Gray3)),
                            GTTextFormField(
                              enableInteractiveSelection: false,
                              controller:
                                  controller.passwordCheckTextController,
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            controller.obx(
              (_) => Obx(
                () => GTKeyboardReactiveButton(
                  disabled: !controller.passwordInputValidity,
                  onTap: controller.moveToThirdPage,
                  child: Text(
                    "다음",
                    style: AppTextTheme.T4.copyWith(color: AppColorTheme.white),
                  ),
                ),
              ),
              onLoading: const GTKeyboardReactiveButton(
                disabled: false,
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: LOADINGINDICATOR,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
