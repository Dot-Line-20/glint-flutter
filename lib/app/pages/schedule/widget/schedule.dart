import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/data/models/schedule.dart';

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

  Widget _item(Schedule scheduleList) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                scheduleList.startingAt.toString(),
                style: AppTextTheme.mediumBlue_10,
              ),
              Text(
                scheduleList.name,
                style: AppTextTheme.boldGray1_18,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column _notExist() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SvgPicture.asset("assets/images/none.svg", width: 150, height: 150),
      const SizedBox(height: 16),
      const Text("아직 일정이 없네요", style: AppTextTheme.boldGray1_16),
      const SizedBox(height: 16),
      const Text.rich(
        TextSpan(
          style: AppTextTheme.mediumGray2_12,
          children: [
            TextSpan(text: "추가하기 버튼을 통해\n"),
            TextSpan(text: "빠르게 일정을 추가할 수 있습니다"),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    ]);
  }
}
