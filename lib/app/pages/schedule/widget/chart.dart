import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/data/module/schedule/schedule.dart';
import 'package:glint/app/data/module/user/user.dart';
import 'package:glint/app/pages/schedule/widget/add.dart';

class TimeLineChart extends StatelessWidget {
  final AnimationController animationController;
  final DateTime fromDate;
  final DateTime toDate;
  final List<Schedule> data;

  late int viewRange;
  final int viewRangeToFitScreen = 6;
  late Animation<double> width;

  TimeLineChart({
    Key? key,
    required this.animationController,
    required this.fromDate,
    required this.toDate,
    required this.data,
  }) : super(key: key) {
    viewRange = calculateNumberOfDaysBetween(fromDate, toDate);
    width = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 1, curve: Curves.fastOutSlowIn),
      ),
    );
  }
  Color randomColorGenerator() {
    Random r = Random();
    return Color.fromRGBO(r.nextInt(256), r.nextInt(256), r.nextInt(256), 0.75);
  }

  int calculateNumberOfMonthsBetween(DateTime from, DateTime to) {
    return to.month - from.month + 12 * (to.year - from.year) + 1;
  }

  int calculateNumberOfDaysBetween(DateTime from, DateTime to) {
    return to.difference(from).inDays + 1;
  }

  int calculateDistanceToLeftBorder(DateTime projectStartedAt) {
    if (projectStartedAt.compareTo(fromDate) <= 0) {
      return 0;
    } else {
      return calculateNumberOfDaysBetween(fromDate, projectStartedAt) - 1;
    }
  }

  int calculateRemainingWidth(
      DateTime projectStartedAt, DateTime projectEndedAt) {
    int projectLength =
        calculateNumberOfDaysBetween(projectStartedAt, projectEndedAt);
    if (projectStartedAt.compareTo(fromDate) >= 0 &&
        projectStartedAt.compareTo(toDate) <= 0) {
      if (projectLength <= viewRange) {
        return projectLength;
      } else {
        return viewRange -
            calculateNumberOfDaysBetween(fromDate, projectStartedAt);
      }
    } else if (projectStartedAt.isBefore(fromDate) &&
        projectEndedAt.isBefore(fromDate)) {
      return 0;
    } else if (projectStartedAt.isBefore(fromDate) &&
        projectEndedAt.isBefore(toDate)) {
      return projectLength -
          calculateNumberOfDaysBetween(projectStartedAt, fromDate);
    } else if (projectStartedAt.isBefore(fromDate) &&
        projectEndedAt.isAfter(toDate)) {
      return viewRange;
    }
    return 0;
  }

  Widget buildHeader(double chartViewWidth, Color color) {
    List<Widget> headerItems = [];

    DateTime tempDate = fromDate;

    for (int i = 0; i < viewRange; i++) {
      headerItems.add(SizedBox(
        width: chartViewWidth / viewRangeToFitScreen,
        child: Text('${tempDate.year}/${tempDate.month}/${tempDate.day}',
            textAlign: TextAlign.center,
            style: AppTextTheme.Explain.copyWith(color: AppColorTheme.white)),
      ));
      //nextMonth
      tempDate = DateTime(tempDate.year, tempDate.month, tempDate.day + 1);
    }

    return Container(
      color: color.withAlpha(220),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: headerItems,
        ),
      ),
    );
  }

  Widget buildGrid(double chartViewWidth) {
    List<Widget> gridColumns = [];

    for (int i = 0; i <= viewRange; i++) {
      gridColumns.add(Container(
        decoration: BoxDecoration(
            border: Border(
                right:
                    BorderSide(color: Colors.grey.withAlpha(100), width: 1.0))),
        width: chartViewWidth / viewRangeToFitScreen,
        //height: 300.0,
      ));
    }

    return Row(
      children: gridColumns,
    );
  }

  List<Widget> buildChartBars(
      List<Schedule> data, double chartViewWidth, Color color) {
    List<Widget> chartBars = [];

    for (int i = 0; i < data.length; i++) {
      var remainingWidth =
          calculateRemainingWidth(data[i].startingAt, data[i].endingAt);
      if (remainingWidth > 0) {
        chartBars.add(Container(
          decoration: BoxDecoration(
              color: color.withAlpha(100),
              borderRadius: BorderRadius.circular(6)),
          height: 25.0,
          width: remainingWidth * chartViewWidth / viewRangeToFitScreen,
          margin: EdgeInsets.only(
              left: calculateDistanceToLeftBorder(data[i].startingAt) *
                  chartViewWidth /
                  viewRangeToFitScreen,
              top: i == 0 ? 4.0 : 2.0,
              bottom: i == data.length - 1 ? 4.0 : 2.0),
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              data[i].name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextTheme.T7,
            ),
          ),
        ));
      }
    }

    return chartBars;
  }

  Widget buildChartForEachUser(List<Schedule> userData, double chartViewWidth) {
    Color color = AppColorTheme.BUTTON1;
    var chartBars = buildChartBars(userData, chartViewWidth, color);
    return ListView(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Stack(
            fit: StackFit.loose,
            children: <Widget>[
              buildGrid(chartViewWidth),
              buildHeader(chartViewWidth, color),
              Container(
                margin: const EdgeInsets.only(top: 25.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: chartBars,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    double chartViewWidth = MediaQuery.of(context).size.width - 20.0;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                              DeviceOrientation.portraitUp,
                              DeviceOrientation.portraitDown,
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
        Expanded(child: buildChartForEachUser(data, chartViewWidth)),
      ],
    );
  }
}
