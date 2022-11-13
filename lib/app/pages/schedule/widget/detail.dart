import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/data/module/schedule/controller.dart';
import 'package:glint/app/data/module/schedule/schedule.dart';
import 'package:glint/app/pages/schedule/widget/add.dart';

import 'package:glint/app/core/util/extension.dart';
import 'package:glint/app/widgets/bottom_sheet.dart';

class DetailSchedule extends StatelessWidget {
  final Schedule schedule;

  const DetailSchedule({Key? key, required this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          schedule.name,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              GTActionType? result =
                  await GTBottomSheet([GTActionType.delete]).show();
              if (result == GTActionType.delete) {
                ScheduleController.to.deleteSchedule(schedule.id);
              }
            },
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${schedule.startingAt.format} ~ ${schedule.endingAt.format}",
                              style: AppTextTheme.T6),
                          Text(
                              "${schedule.startingAt.format2} ~ ${schedule.endingAt.format2}",
                              style: AppTextTheme.T6),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.description, size: 16),
                      const SizedBox(width: 16),
                      Expanded(
                          child: Text(schedule.content,
                              style: AppTextTheme.Explain)),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
