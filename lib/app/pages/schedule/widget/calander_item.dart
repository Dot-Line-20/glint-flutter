import 'package:flutter/material.dart';
import 'package:glint/app/core/theme/color_theme.dart';

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
