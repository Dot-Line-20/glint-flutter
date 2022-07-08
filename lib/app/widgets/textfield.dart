import 'package:firebase_getx_boilerplate/app/core/color_theme.dart';
import 'package:firebase_getx_boilerplate/app/core/text_theme.dart';
import 'package:flutter/material.dart';

class FGBPTextField extends StatelessWidget {
  const FGBPTextField({Key? key, required this.textController, this.hintText})
      : super(key: key);

  final String? hintText;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      style: AppTextTheme.regularBlack,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintStyle: AppTextTheme.regularGrey,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColorTheme.mainColor, width: 5.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColorTheme.mainColor, width: 5.0),
        ),
        fillColor: AppColorTheme.white,
        filled: true,
        hintText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        focusColor: AppColorTheme.mainColor,
      ),
    );
  }
}
