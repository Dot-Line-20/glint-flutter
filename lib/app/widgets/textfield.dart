import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';

class FGBPTextField extends StatelessWidget {
  const FGBPTextField({
    Key? key,
    required this.textController,
    this.hintText,
    this.inputType = TextInputType.none,
    this.borderColor = AppColorTheme.BUTTON1,
  }) : super(key: key);

  final TextEditingController textController;
  final String? hintText;
  final TextInputType? inputType;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      controller: textController,
      style: AppTextTheme.regularGrey1_12,
      cursorColor: AppColorTheme.black,
      decoration: InputDecoration(
        hintStyle: AppTextTheme.regularGrey1_12,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 3),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 3),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        fillColor: AppColorTheme.white,
        filled: true,
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        focusColor: AppColorTheme.BUTTON1,
      ),
    );
  }
}
