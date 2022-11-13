import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';

class Empty extends StatelessWidget {
  final String title;
  final String description;
  const Empty({Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: SvgPicture.asset("assets/images/none.svg"),
          ),
          const SizedBox(height: 16),
          Text(title, style: AppTextTheme.T5),
          const SizedBox(height: 8),
          Text(description,
              style: AppTextTheme.T7.copyWith(color: AppColorTheme.Gray2)),
        ],
      ),
    );
  }
}
