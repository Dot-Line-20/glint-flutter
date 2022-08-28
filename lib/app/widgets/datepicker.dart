import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:kitopi_app/constants.dart';

enum PickerDateComponent { day, month, year }

class DatePicker extends StatefulWidget {
  DateTime? upperLimit;
  DateTime? lowerLimit;

  Function dateChangedCallback;

  DatePicker({
    this.upperLimit,
    this.lowerLimit,
    required this.dateChangedCallback,
  });

  DatePicker.upperLimit({this.upperLimit, required this.dateChangedCallback});
  DatePicker.lowerLimit({this.lowerLimit, required this.dateChangedCallback});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime currentDate = DateTime.now().toLocal();
  DateTime today = DateTime.now().toLocal();

  String get _yesterDay {
    int yDay = currentDate.day - 1 > 0
        ? currentDate.day - 1
        : DateUtils.getDaysInMonth(currentDate.year, currentDate.month);

    return yDay.toString();
  }

  String get _day {
    return currentDate.day.toString();
  }

  String get _nextDay {
    int numOfDays =
        DateUtils.getDaysInMonth(currentDate.year, currentDate.month);
    int tDay = currentDate.day + 1 <= numOfDays ? currentDate.day + 1 : 1;

    return tDay.toString();
  }

  String get _yesterMonth {
    int lastMonth = currentDate.month - 1 > 0 ? currentDate.month - 1 : 12;
    int maxDays = DateUtils.getDaysInMonth(currentDate.year, lastMonth);

    DateTime yDate = DateTime(currentDate.year, lastMonth, maxDays);
    // debugPrint(DateFormat.MMM().format(yDate));
    // debugPrint(lastMonth.toString());

    return DateFormat.MMM().format(yDate);
  }

  String get _month {
    return DateFormat.MMM().format(currentDate);
  }

  String get _nextMonth {
    int nextMonth = currentDate.month + 1 <= 12 ? currentDate.month + 1 : 1;
    // debugPrint(nextMonth.toString());
    int maxDays = DateUtils.getDaysInMonth(currentDate.year, nextMonth);

    DateTime yDate = DateTime(currentDate.year, nextMonth, maxDays);
    // debugPrint(DateFormat.MMM().format(yDate));
    return DateFormat.MMM().format(yDate);
  }

  String get _yesterYear {
    return (currentDate.year - 1).toString();
  }

  String get _year {
    return currentDate.year.toString();
  }

  String get _nextYear {
    return (currentDate.year + 1).toString();
  }

  int get daysInMonth {
    return DateUtils.getDaysInMonth(currentDate.year, currentDate.month);
  }

  @override
  Widget build(BuildContext context) {
    return datePickerContainer();
  }

  Widget datePickerContainer() {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Row(
          children: [
            // Year
            _dates(_yesterYear, _year, _nextYear, PickerDateComponent.year),
            // Month
            _dates(_yesterMonth, _month, _nextMonth, PickerDateComponent.month),
            // Day
            _dates(_yesterDay, _day, _nextDay, PickerDateComponent.day),
          ],
        ),
      ),
    );
  }

  Widget _dates(String yesterData, String todayData, String tomorrowData,
      PickerDateComponent comp) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Up Arrow
          InkWell(
            child: const Icon(Icons.arrow_drop_up),
            /*const Image(
              image: AssetImage("resources/images/top_arrow.png"),
              height: 14,
              width: 24,
            ),*/
            onTap: () {
              final lLimit = widget.lowerLimit;

              if (comp == PickerDateComponent.day) {
                int yDay = currentDate.day - 1 > 0
                    ? currentDate.day - 1
                    : DateUtils.getDaysInMonth(
                        currentDate.year, currentDate.month);
                DateTime tempDate =
                    DateTime(currentDate.year, currentDate.month, yDay);

                setState(() {
                  if (lLimit == null) {
                    currentDate = tempDate;
                    widget.dateChangedCallback(currentDate);
                  } else if (tempDate.compareTo(lLimit) >= 0) {
                    currentDate = tempDate;
                    widget.dateChangedCallback(currentDate);
                  }
                });
              } else if (comp == PickerDateComponent.month) {
                int lastMonth =
                    currentDate.month - 1 > 0 ? currentDate.month - 1 : 12;

                int maxDays =
                    DateUtils.getDaysInMonth(currentDate.year, lastMonth);
                DateTime tempDate = DateTime(currentDate.year, lastMonth,
                    maxDays < currentDate.day ? maxDays : currentDate.day);

                setState(() {
                  if (lLimit == null) {
                    currentDate = tempDate;
                    widget.dateChangedCallback(currentDate);
                  } else if (tempDate.compareTo(lLimit) >= 0) {
                    currentDate = tempDate;
                    widget.dateChangedCallback(currentDate);
                  }
                });
              } else if (comp == PickerDateComponent.year) {
                DateTime tempDate = DateTime(
                    currentDate.year - 1, currentDate.month, currentDate.day);

                setState(() {
                  if (lLimit == null) {
                    currentDate = tempDate;
                    widget.dateChangedCallback(currentDate);
                  } else if (tempDate.compareTo(lLimit) >= 0) {
                    currentDate = tempDate;
                    widget.dateChangedCallback(currentDate);
                  }
                });
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),

          // Text

          Text(
            yesterData,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              //rgba(25, 25, 25, 0.25)
              color: Theme.of(context).disabledColor,
            ),
          ),
          // Divider rgba(238, 117, 24, 1)
          const SizedBox(
            height: 10,
          ),

          divider(),
          //Text
          const SizedBox(
            height: 10,
          ),

          Text(
            todayData,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          //Divider
          const SizedBox(
            height: 10,
          ),
          divider(),
          // Text
          const SizedBox(
            height: 10,
          ),

          Text(
            tomorrowData,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              //rgba(25, 25, 25, 0.25)
              color: Theme.of(context).disabledColor,
            ),
          ),
          const SizedBox(
            height: 15,
          ),

          InkWell(
            child: const Icon(Icons.arrow_drop_down),
            /*const Image(
              image: AssetImage("resources/images/bottom_arrow.png"),
              height: 14,
              width: 24,
            )*/
            onTap: () {
              final uLimit = widget.upperLimit;

              if (comp == PickerDateComponent.day) {
                int numOfDays = DateUtils.getDaysInMonth(
                    currentDate.year, currentDate.month);
                int tDay =
                    currentDate.day + 1 <= numOfDays ? currentDate.day + 1 : 1;
                DateTime tempDate =
                    DateTime(currentDate.year, currentDate.month, tDay);
                if (uLimit == null) {
                  setState(() {
                    currentDate = tempDate;
                    widget.dateChangedCallback(currentDate);
                  });
                } else if (tempDate.compareTo(uLimit) <= 0) {
                  setState(() {
                    currentDate = tempDate;
                    widget.dateChangedCallback(currentDate);
                  });
                }
              } else if (comp == PickerDateComponent.month) {
                int nextMonth =
                    currentDate.month + 1 <= 12 ? currentDate.month + 1 : 1;
                int maxDays =
                    DateUtils.getDaysInMonth(currentDate.year, nextMonth);

                setState(() {
                  DateTime tempDate = DateTime(currentDate.year, nextMonth,
                      maxDays < currentDate.day ? maxDays : currentDate.day);
                  if (uLimit == null) {
                    currentDate = tempDate;
                    widget.dateChangedCallback(currentDate);
                  } else if (tempDate.compareTo(uLimit) <= 0) {
                    currentDate = tempDate;
                    widget.dateChangedCallback(currentDate);
                  }
                });
              } else if (comp == PickerDateComponent.year) {
                DateTime tempDate = DateTime(
                    currentDate.year + 1, currentDate.month, currentDate.day);
                setState(() {
                  if (uLimit == null) {
                    currentDate = tempDate;
                    widget.dateChangedCallback(currentDate);
                  } else if (tempDate.compareTo(uLimit) <= 0) {
                    currentDate = tempDate;
                    widget.dateChangedCallback(currentDate);
                  }
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget divider() {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 20,
      endIndent: 20,
      color: Theme.of(context).dividerColor,
    );
  }
}
