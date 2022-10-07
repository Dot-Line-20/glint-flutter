import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glint/app/core/theme/text_theme.dart';

class ScheduleList extends StatelessWidget {
  final List<Map> scheduleList;

  const ScheduleList({Key? key, required this.scheduleList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _notExist();
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
