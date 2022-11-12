import 'package:glint/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/pages/schedule/controller.dart';
import 'package:glint/app/pages/schedule/widget/schedule.dart';
import 'package:glint/app/routes/route.dart';
import 'package:glint/app/widgets/button.dart';

class SchedulePage extends GetView<SchedulePageController> {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("일정",
                textAlign: TextAlign.start, style: AppTextTheme.Title),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() => ScheduleList(
                    scheduleList: controller.scheduleList,
                  )),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GTSmallTextButton(
                  text: "추가하기",
                  onTap: controller.pickSchedule,
                ),
                GTSmallTextButton(
                  text: "카테고리",
                  onTap: () {
                    Get.toNamed(Routes.category);
                  },
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
