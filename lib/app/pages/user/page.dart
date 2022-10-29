import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/data/module/user/service.dart';
import 'package:glint/app/data/service/auth/service.dart';
import 'package:glint/app/routes/route.dart';
import 'package:glint/app/widgets/button.dart';

class UserPage extends StatelessWidget {
  UserPage({Key? key}) : super(key: key);

  final AuthService authService = Get.find<AuthService>();
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              const SizedBox(height: 20),
              followInfo(),
              const SizedBox(height: 20),
              stories(),
              const SizedBox(height: 20),
              successRate(),
              const Expanded(child: SizedBox()),
              GTMediumTextButton(
                  text: "로그아웃",
                  onTap: () {
                    authService.logout();
                    Get.offNamed(Routes.login);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget successRate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "목표 성취 확률",
              style: AppTextTheme.boldGray1_20,
            ),
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                style: AppTextTheme.mediumGray2_12,
                children: [
                  const TextSpan(
                      text: "이 유저는 ", style: AppTextTheme.mediumGray2_14),
                  TextSpan(
                      text: "${userController.successRate}%",
                      style: AppTextTheme.boldGray1_16),
                  const TextSpan(
                      text: "확률로\n", style: AppTextTheme.mediumGray2_14),
                  const TextSpan(
                      text: "목표 달성할 ", style: AppTextTheme.mediumGray2_14),
                  const TextSpan(
                      text: "가능성이 높습니다.", style: AppTextTheme.boldGray1_16),
                ],
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
        SvgPicture.asset("assets/images/goal.svg")
      ],
    );
  }

  Widget header() {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColorTheme.BUTTON1,
          ),
          height: 44,
          width: 44,
        ),
        const SizedBox(width: 10),
        Text(
          userController.userInfo?.name ?? "",
          style: AppTextTheme.boldHGray1_26,
        ),
      ],
    );
  }

  Widget followInfo() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColorTheme.Gray3,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: const [
                Text("목표 달성 수", style: AppTextTheme.mediumGray2_14),
                Text("321", style: AppTextTheme.boldGray1_18),
              ],
            ),
            Column(
              children: const [
                Text("팔로우", style: AppTextTheme.mediumGray2_14),
                Text("1,200", style: AppTextTheme.boldGray1_18),
              ],
            ),
            Column(
              children: const [
                Text("목표 달성 수", style: AppTextTheme.mediumGray2_14),
                Text("1,250", style: AppTextTheme.boldGray1_18),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget stories() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) => _storyItem(),
      ),
    );
  }

  Widget _storyItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: Column(
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColorTheme.BUTTON1,
            ),
          ),
          const SizedBox(height: 8),
          const Text("EXAMPLE")
        ],
      ),
    );
  }
}
