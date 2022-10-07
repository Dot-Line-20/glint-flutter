import 'package:flutter_svg/flutter_svg.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/pages/schedule/controller.dart';

//BottomNav + 끌어올리기

//타임라인 만들기

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
          children: const [
            Text("일정", style: AppTextTheme.boldHGray1_24),
            SizedBox(height: 8),
            Text("홍보용 문구", style: AppTextTheme.boldGray2_14),
            SizedBox(height: 70),
            Expanded(child: TransactionCalendarViewer()),
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

    final startDay = DateTime(now.year, now.month, 0);
    final prevDate = startDay.day;
    final prevDay = startDay.weekday;

    final endDay = DateTime(now.year, now.month + 1, 0);
    final nextDate = endDay.day;
    final nextDay = endDay.weekday;

    List<Widget> dates = [];

    // 지난달
    for (int i = prevDate - prevDay + 1; i <= prevDate; i++) {
      dates.add(TransactionCalendarViewerDateItem(
          date: i, lastday: true, isHighlighted: false));
    }
    for (int i = 1; i <= nextDate; i++) {
      dates.add(
          TransactionCalendarViewerDateItem(date: i, isHighlighted: false));
    }
    for (int i = 1; i <= (7 - nextDay == 7 ? 0 : 7 - nextDay); i++) {
      dates.add(TransactionCalendarViewerDateItem(
          date: i, lastday: true, isHighlighted: false));
    }

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
              SvgPicture.asset('assets/images/left_arrow.svg'),
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
              SvgPicture.asset('assets/images/right_arrow.svg'),
            ],
          ),
          //TabBarView(children: children)
          const SizedBox(height: 12),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: weekdays.map((e) => Text("$e")).toList(),
                ),
              ),
              CalenderSetViewer(dates: dates)
            ],
          )
        ],
      ),
    );
  }
}

class CalenderSetViewer extends StatelessWidget {
  final List<Widget> dates;

  const CalenderSetViewer({Key? key, required this.dates}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 7,
      children: dates,
    );
  }
}

class TransactionCalendarViewerDateItem extends StatelessWidget {
  final int date;
  final bool lastday;
  final bool isHighlighted;
  const TransactionCalendarViewerDateItem({
    required this.date,
    this.lastday = false,
    this.isHighlighted = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                date.toString(),
                style: TextStyle(
                    color: lastday
                        ? Colors.grey
                        : Colors
                            .black), //isHighlighted ? Colors.white : Colors.black
              ),
            ),
          ),
        )
      ],
    );
  }
}
