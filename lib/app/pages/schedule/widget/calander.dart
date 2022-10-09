import 'package:flutter/material.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/pages/schedule/widget/calander_item.dart';

class CalendarViewer extends StatelessWidget {
  final DateTime now;

  const CalendarViewer({Key? key, required this.now}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weekdays = ['월', '화', '수', '목', '금', '토', '일'];

    final startDay = DateTime(now.year, now.month, 0);
    final prevDate = startDay.day;
    final prevDay = startDay.weekday;

    final endDay = DateTime(now.year, now.month + 1, 0);
    final nextDate = endDay.day;
    final nextDay = endDay.weekday;

    List<Widget> dates = [];

    // 지난달
    for (int i = prevDate - prevDay + 1; i <= prevDate; i++) {
      dates.add(
          CalendarViewerDateItem(date: i, lastday: true, isHighlighted: false));
    }
    for (int i = 1; i <= nextDate; i++) {
      if (i == now.day) {
        dates.add(CalendarViewerDateItem(date: i, isHighlighted: true));
      } else {
        dates.add(CalendarViewerDateItem(date: i, isHighlighted: false));
      }
    }
    // 다음달
    for (int i = 1; i <= (7 - nextDay == 7 ? 0 : 7 - nextDay); i++) {
      dates.add(
          CalendarViewerDateItem(date: i, lastday: true, isHighlighted: false));
    }

    return SizedBox(
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TabBarView(children: children)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: weekdays
                      .map((e) => Text(
                            e,
                            style: AppTextTheme.semiboldGrey2_14,
                          ))
                      .toList(),
                ),
              ),
              GridView.count(
                padding: EdgeInsets.zero,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 7,
                children: dates,
              )
            ],
          )
        ],
      ),
    );
  }
}
