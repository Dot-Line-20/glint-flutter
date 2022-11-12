import 'package:flutter/services.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/module/user/controller.dart';
import 'package:glint/app/data/service/orientation/service.dart';
import 'package:glint/app/pages/home/controller.dart';
import 'package:glint/app/pages/schedule/controller.dart';
import 'package:glint/app/pages/schedule/widget/add.dart';
import 'package:glint/app/pages/schedule/widget/chart.dart';
import 'package:glint/app/pages/schedule/widget/schedule.dart';

class SchedulePage extends GetView<SchedulePageController> {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        SafeArea(child: OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.landscape) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          OrientationService.to.updateOrientation(true);
        });
        return TimeLineChart(
          animationController: controller.animationController,
          fromDate: controller.now.subtract(const Duration(days: 7)),
          toDate: controller.now.add(const Duration(days: 7)),
          data: controller.scheduleList,
        );
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        OrientationService.to.updateOrientation(false);
      });

      return Column(
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
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              SystemChrome.setPreferredOrientations([
                                DeviceOrientation.landscapeLeft,
                                DeviceOrientation.landscapeRight,
                              ]);
                            },
                            icon: const Icon(Icons.rotate_left)),
                        IconButton(
                            onPressed: () {
                              PickSchedule().show();
                            },
                            icon: const Icon(Icons.add))
                      ],
                    ),
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
      );
    })));
  }
}
