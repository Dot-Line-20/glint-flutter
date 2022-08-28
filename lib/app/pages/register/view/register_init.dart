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
                  const Text("회원가입", style: AppTextTheme.boldHGray1_24),
                  const SizedBox(height: 8),
                  const Text("GLINT를 시작해보아요!",
                      style: AppTextTheme.boldGray2_14),
                  const SizedBox(height: 50),
                  Form(
                    key: controller.formKey,
                    child: FocusScope(
                        node: controller.formFocusScopeNode,
                        child: Column(
                          children: [
                            FGBPTextFormField(
                              enableInteractiveSelection: false,
                              controller: controller.nameTextController,
                              label: "이름",
                            ),
                            const SizedBox(height: 20),
                            FGBPTextFormField(
                              enableInteractiveSelection: false,
                              controller: controller.emailTextController,
                              label: "이메일",
                            ),
                            const SizedBox(height: 20),
                            FGBPTextFormField(
                              readOnly: true,
                              onTap: controller.pickDateTime,
                              textInputType: TextInputType.datetime,
                              enableInteractiveSelection: false,
                              controller: controller.birthDayController,
                              label: "생년월일",
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
                  disabled: !controller.initInputValidity,
                  onTap: controller.moveToSecondPage,
                  child: const Text(
                    "다음",
                    style: AppTextTheme.boldWhite_18,
                  ),
                ),
              ),
              onLoading: FGBPKeyboardReactiveButton(
                disabled: !controller.initInputValidity,
                child: const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: AppColorTheme.white,
                    strokeWidth: 2,
                  ),
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      )),
    );
  }
}
