import 'package:glint/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/pages/schedule/controller.dart';
import 'package:glint/app/pages/schedule/widget/calander.dart';
import 'package:glint/app/pages/schedule/widget/schedule.dart';
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
            const SizedBox(height: 16),
            const Text("일정",
                textAlign: TextAlign.start, style: AppTextTheme.boldHGray1_24),
            const SizedBox(height: 32),
            CalendarViewer(
              now: controller.now,
              scheduleList: const [],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                GTSmallTextButton(
                  text: "추가하기",
                  onTap: controller.pickSchedule,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() => ScheduleList(
                    scheduleList: controller.scheduleList,
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
