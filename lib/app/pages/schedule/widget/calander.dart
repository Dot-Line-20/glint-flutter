import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/data/module/schedule/schedule.dart';

class Range {
  final DateTime? start;
  final DateTime? end;

  int? startDay;
  int? endDay;

  Range({this.start, this.end, this.startDay = 0, this.endDay = 0}) {
    if (start != null && end != null) {
      startDay = start!.day;
      endDay = end!.day;
    }
  }

  bool isInclude(int data) {
    return data >= startDay! && data <= endDay!;
  }

  bool isIncludeRange(Range data) {
    return isInclude(data.startDay!) || isInclude(data.endDay!);
  }
}

class CalendarViewer extends StatelessWidget {
  final DateTime now;
  final List<Schedule> scheduleList;

  const CalendarViewer(
      {Key? key, required this.now, required this.scheduleList})
      : super(key: key);

  List<Widget> calcDate() {
    List<Widget> dates = [];

    final startDay = DateTime(now.year, now.month, 0);
    final prevDate = startDay.day;
    final prevDay = startDay.weekday;

    final endDay = DateTime(now.year, now.month + 1, 0);
    final nextDate = endDay.day;
    final nextDay = endDay.weekday;
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
    return dates;
  }

  List<Range> calcRange() {
    List<Range> ranges = [];
    for (int i = 0; i < scheduleList.length; i++) {
      ranges.add(Range(
          start: scheduleList[i].startingAt, end: scheduleList[i].endingAt));
    }
    return ranges;
  }

  @override
  Widget build(BuildContext context) {
    final weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    List<Widget> dates = calcDate();

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TabBarView(children: children)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: weekdays
                    .map((e) => Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              e,
                              style: AppTextTheme.T6
                                  .copyWith(color: AppColorTheme.Gray3),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 13),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColorTheme.Gray4,
                ),
              ),
              Column(children: [
                for (int i = 0; i < dates.length; i += 7)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: dates.sublist(i, i + 7),
                      ),
                      // TimeLine(
                      //     range: Range(startDay: i, endDay: i + 7), ranges: []),
                    ],
                  )
              ]),
            ],
          )
        ],
      ),
    );
  }
}

class TimeLine extends StatelessWidget {
  final Range range;
  final List<Range> ranges;

  const TimeLine({Key? key, required this.range, required this.ranges})
      : super(key: key);

  // Seven equal portion of the screen Width
  double get width => ((Get.width) - 32) / 7;

  @override
  Widget build(BuildContext context) {
    List<bool> temp = [false, true, true, true, false, false, false];
    return Row(
      children: [
        for (int i = range.startDay!; i <= range.endDay!; i++)
          TimeLineItem(
            width: width,
            isHighlighted: temp[i],
          ),
      ],
    );
  }
}

class TimeLineItem extends StatelessWidget {
  final double width;
  final bool start, end;
  final bool isHighlighted;

  const TimeLineItem(
      {Key? key,
      required this.width,
      this.isHighlighted = false,
      this.start = false,
      this.end = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(start ? 5 : 0),
            topRight: Radius.circular(end ? 5 : 0)),
        color: isHighlighted ? AppColorTheme.Blue : Colors.transparent,
      ),
    );
  }
}

class CalendarViewerDateItem extends StatelessWidget {
  final int date;
  final bool lastday;
  final bool isHighlighted;
  const CalendarViewerDateItem({
    required this.date,
    this.lastday = false,
    this.isHighlighted = false,
    Key? key,
  }) : super(key: key);

  TextStyle get _textStyle {
    if (isHighlighted) {
      return AppTextTheme.T6.copyWith(color: AppColorTheme.white);
    } else if (lastday) {
      return AppTextTheme.T6.copyWith(color: AppColorTheme.Gray3);
    } else {
      return AppTextTheme.T6.copyWith(color: AppColorTheme.Gray2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Center(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isHighlighted ? AppColorTheme.Blue : Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                date.toString().padLeft(2, "0"),
                style: _textStyle, //isHighlighted ? Colors.white : Colors.black
              ),
            ),
          ),
        ),
        //Blue dot

        //timeline Line
      ],
    );
  }
}
