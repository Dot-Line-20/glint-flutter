// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';

abstract class AppColorTheme {
  /// Main Color
  static const Blue = Color(0xff1372A7);
  static get Blue_50 => const Color(0xff1372A7).withOpacity(0.5);
  static const Purple = Color(0xff9A58CE);
  static const Sys_Green = Color(0xff95C235);
  static const Sys_Red = Color(0xffDD3B3B);

  /// Base Gray
  static const Gray1 = Color(0xff141517);
  static const Gray2 = Color(0xff5E5E67);
  static const Gray3 = Color(0xffA9A9B5);
  static const Gray3_1 = Color(0xffA9A9B5);
  static const Gray4 = Color(0xffE8E8E8);
  static const Gray5 = Color(0xffF3F3F3);
  static const Gray6 = Color(0xffF3F3F3);

  /// button style
  static const BUTTON1 = Color(0xff121D56);
  static const BUTTON2 = Color(0xff484A5E);

  /// material
  static const black = Colors.black;
  static const white = Colors.white;
  static get white_60 => Colors.white.withOpacity(0.6);
}
