import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/data/module/schedule/schedule.dart';
import 'package:glint/app/pages/schedule/widget/detail.dart';

import 'package:glint/app/core/util/extension.dart';

class ScheduleList extends StatelessWidget {
  final List<Schedule> scheduleList;

  const ScheduleList({Key? key, required this.scheduleList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return scheduleList.isNotEmpty ? _exist() : _notExist();
  }

  Widget _exist() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: scheduleList.length,
      itemBuilder: (BuildContext context, int index) {
        return _item(scheduleList[index]);
      },
    );
  }

  Widget _item(Schedule schedule) {
    int duration = schedule.endingAt.day - schedule.startingAt.day;
    int durationHour = schedule.endingAt.hour - schedule.startingAt.hour;
    int durationMinute = schedule.endingAt.minute - schedule.startingAt.minute;
    String durationText = "";
    if (duration > 0) {
      durationText += "(+$duration일)";
    } else if (durationHour == 23 && durationMinute == 59) {
      durationText = "하루종일";
    } else if (durationHour > 0) {
      durationText = "(+$durationHour시간)";
    } else if (durationMinute > 0) {
      durationText = "(+$durationMinute분)";
    }

    return GestureDetector(
      onTap: () {
        // Get.toNamed("/schedule/detail", arguments: schedule);
        Get.to(() => DetailSchedule(schedule: schedule));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: const BoxDecoration(color: AppColorTheme.white),
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // (start.day - end.day) Day
                Text(
                  "${schedule.startingAt.format} $durationText",
                  style: AppTextTheme.T5.copyWith(color: AppColorTheme.BUTTON1),
                ),
                Text(
                  schedule.name,
                  style: AppTextTheme.T3,
                ),
                const SizedBox(height: 16),
                Text(schedule.content, style: AppTextTheme.Explain),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (durationHour != 0)
                      Text(
                        "${schedule.startingAt.format2} ~ ${schedule.endingAt.format2}",
                        style: AppTextTheme.T5.copyWith(
                            color: AppColorTheme.BUTTON1, fontSize: 12),
                      ),
                    Row(
                        children: schedule.categories
                            .map(
                              (e) => Container(
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: AppColorTheme.BUTTON1,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 4),
                                  child: Text(
                                    e.categoryId.toString(),
                                    style: AppTextTheme.T6
                                        .copyWith(color: AppColorTheme.white),
                                  ),
                                ),
                              ),
                            )
                            .toList()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _notExist() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/none.svg", width: 150, height: 150),
          const SizedBox(height: 16),
          const Text("아직 일정이 없네요", style: AppTextTheme.T5),
          const SizedBox(height: 16),
          Text.rich(
            TextSpan(
              style: AppTextTheme.T7.copyWith(color: AppColorTheme.Gray2),
              children: const [
                TextSpan(text: "추가하기 버튼을 통해\n"),
                TextSpan(text: "빠르게 일정을 추가할 수 있습니다"),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
