import 'package:flutter/scheduler.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/pages/schedule/controller.dart';
import 'package:glint/app/pages/schedule/widget/add.dart';
import 'package:glint/app/pages/schedule/widget/schedule.dart';

class SchedulePage extends GetView<SchedulePageController> {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("일정",
                        textAlign: TextAlign.start, style: AppTextTheme.Title),
                    //add Button
                    IconButton(
                        onPressed: () {
                          PickSchedule().show();
                        },
                        icon: const Icon(Icons.add))
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() => ScheduleList(
                  scheduleList: controller.scheduleList,
                )),
          ),
          const SizedBox(height: 4),
        ],
      )),
    );
  }
}
