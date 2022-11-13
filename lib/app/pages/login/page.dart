import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/pages/login/controller.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/constant.dart';
import 'package:glint/app/widgets/textfield.dart';

class LoginPage extends GetView<LoginPageController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("로그인", style: AppTextTheme.Title),
              const SizedBox(height: 8),
              Text("홍보용 문구",
                  style: AppTextTheme.T6.copyWith(color: AppColorTheme.Gray2)),
              const SizedBox(height: 70),
              Form(
                key: controller.formKey,
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
                        Text("비밀번호",
                            style: AppTextTheme.T6
                                .copyWith(color: AppColorTheme.Gray3)),
                        GTTextFormField(
                          maxLines: 1,
                          isPassword: true,
                          enableInteractiveSelection: false,
                          controller: controller.passwordTextController,
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 50),
              controller.obx(
                (_) => Obx(
                  () => GTKeyboardReactiveButton(
                    disabled: !controller.inputValidity,
                    onTap: controller.inputValidity ? controller.login : null,
                    child: Text(
                      "로그인하기",
                      style:
                          AppTextTheme.T4.copyWith(color: AppColorTheme.white),
                    ),
                  ),
                ),
                onLoading: const GTKeyboardReactiveButton(
                  disabled: false,
                  child:
                      SizedBox(height: 20, width: 20, child: LOADINGINDICATOR),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginHelper(onTap: () {}, content: "아이디 찾기"),
                  const SizedBox(width: 30),
                  LoginHelper(onTap: () {}, content: "비밀번호 찾기"),
                  const SizedBox(width: 30),
                  // LoginHelper(
                  //     onTap: controller.moveToSchedulePage, content: "일정 보기"),
                  // const SizedBox(width: 30),
                  LoginHelper(
                      onTap: controller.moveToRegisterPage, content: "회원가입하기"),
                ],
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialLoginButton(
                      onTap: () {}, imgUrl: "assets/images/facebook.png"),
                  const SizedBox(width: 20),
                  SocialLoginButton(
                      onTap: () {}, imgUrl: "assets/images/kakao.png"),
                  const SizedBox(width: 20),
                  SocialLoginButton(
                      onTap: () {}, imgUrl: "assets/images/google.png"),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({Key? key, required this.onTap, required this.imgUrl})
      : super(key: key);

  final String imgUrl;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffF4F4F4)),
          child: Image.asset(imgUrl)),
    );
  }
}

class LoginHelper extends StatelessWidget {
  const LoginHelper({
    Key? key,
    required this.onTap,
    required this.content,
  }) : super(key: key);

  final Function() onTap;
  final String content;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: onTap,
        child: Text(content, style: AppTextTheme.Main));
  }
}
