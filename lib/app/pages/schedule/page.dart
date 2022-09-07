import 'package:flutter_svg/flutter_svg.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/pages/schedule/controller.dart';

class SchedulePage extends GetView<SchedulePageController> {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("일정", style: AppTextTheme.boldHGray1_24),
            const SizedBox(height: 8),
            const Text("홍보용 문구", style: AppTextTheme.boldGray2_14),
            const SizedBox(height: 70),
            const TransactionCalendarViewer(),
          ],
        ),
      )),
    );
  }
}

class TransactionCalendarViewer extends StatelessWidget {
  const TransactionCalendarViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weekdays = ['월', '화', '수', '목', '금', '토', '일'];

    final DateTime now = DateTime.now();
    int startDay = 1;
    DateTime beforeMonth = DateTime(now.year, now.month, 0);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFD8D8D8)))),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset('asset/images/left_arrow.svg'),
              const SizedBox(width: 10),
              Text(
                "${now.year}년",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 4),
              Text(
                "${now.month}월",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 10),
              SvgPicture.asset('asset/images/right_arrow.svg'),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: weekdays.map((e) => Text("$e")).toList(),
                ),
              ),
              for (int i = ((beforeMonth.day + 1) % 7); i > 0; i--)
                TransactionCalendarViewerDateItem(
                  date: DateTime(now.year, now.month, beforeMonth.day - i + 1),
                  now: now,
                ),
              for (int i = 0; i < 6; i++)
                Row(
                  children: [
                    for (int j = 0; j < 7; j++)
                      TransactionCalendarViewerDateItem(
                        date: DateTime(now.year, now.month, i * 7 + j),
                        now: now,
                      ),
                  ],
                ),
            ],
          )
        ],
      ),
    );
  }
}

class TransactionCalendarViewerDateItem extends StatelessWidget {
  final DateTime date;
  final DateTime now;
  final bool isHighlighted;
  const TransactionCalendarViewerDateItem({
    Key? key,
    required this.date,
    required this.now,
    this.isHighlighted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notSame = date.month != now.month;

    return Flexible(
      child: Column(
        children: [
          const SizedBox(height: 6),
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isHighlighted
                    ? AppColorTheme.BUTTON1
                    : const Color(0xFFF9F9F9),
              ),
              child: Center(
                child: Text(
                  date.day.toString(),
                  style: TextStyle(
                      color: notSame
                          ? Colors.grey
                          : Colors
                              .black), //isHighlighted ? Colors.white : Colors.black
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
