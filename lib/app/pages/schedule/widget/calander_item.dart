import 'package:flutter/material.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';

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
      return AppTextTheme.boldWhite_14;
    } else if (lastday) {
      return AppTextTheme.boldGray3_14;
    } else {
      return AppTextTheme.boldGray2_14;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: isHighlighted ? AppColorTheme.Blue : Colors.transparent,
            ),
            child: Center(
              child: Text(
                date.toString(),
                style: _textStyle, //isHighlighted ? Colors.white : Colors.black
              ),
            ),
          ),
        )
      ],
    );
  }
}
