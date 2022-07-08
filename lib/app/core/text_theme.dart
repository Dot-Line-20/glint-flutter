// ignore_for_file: constant_identifier_names

import 'package:firebase_getx_boilerplate/app/core/color_theme.dart';
import 'package:flutter/material.dart';

abstract class AppTextTheme {
  static const VERYSMALL = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.bold,
      fontSize: 10,
      color: AppColorTheme.mainColor);

  static const SMALL = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: AppColorTheme.mainColor);

  static const REGULAR = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: AppColorTheme.mainColor);

  static const BIG = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.bold,
      fontSize: 30,
      color: AppColorTheme.mainColor);

  static const MAIN = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.bold,
      fontSize: 40,
      color: AppColorTheme.mainColor);
}
