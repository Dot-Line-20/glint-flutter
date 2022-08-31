import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/pages/register/controller.dart';
import 'package:glint/app/widgets/button.dart';
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
                  const Text("회원가입", style: AppTextTheme.boldHGray1_24),
                  const SizedBox(height: 8),
                  const Text("비밀번호는 8자리 이상, 특수문자를 포함해야해요",
                      style: AppTextTheme.boldGray2_14),
                  const SizedBox(height: 50),
                  Form(
                    key: controller.secondFormKey,
                    child: FocusScope(
                        node: controller.formFocusScopeNode,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("아이디", style: AppTextTheme.boldGray3_14),
                            FGBPTextFormField(
                              enableInteractiveSelection: false,
                              controller: controller.idTextController,
                            ),
                            const SizedBox(height: 50),
                            Obx(
                              () => Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("비밀번호",
                                      style: AppTextTheme.boldGray3_14),
                                  FGBPTextFormField(
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
                                          ? AppTextTheme.mediumGreen_12
                                          : AppTextTheme.mediumRed_12,
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 50),
                            const Text("비밀번호 확인",
                                style: AppTextTheme.boldGray3_14),
                            FGBPTextFormField(
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
                () => FGBPKeyboardReactiveButton(
                  disabled: !controller.passwordInputValidity,
                  onTap: controller.moveToThirdPage,
                  child: const Text(
                    "다음",
                    style: AppTextTheme.boldWhite_18,
                  ),
                ),
              ),
              onLoading: const FGBPKeyboardReactiveButton(
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
