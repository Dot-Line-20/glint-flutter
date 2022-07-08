import 'package:firebase_getx_boilerplate/app/core/color_theme.dart';
import 'package:flutter/material.dart';

abstract class AppTextTheme {
  static const verySmall = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.bold,
      fontSize: 10,
      color: AppColorTheme.mainColor);

  static const small = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: AppColorTheme.mainColor);

  static const regular = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: AppColorTheme.mainColor);
  static const regularBlack = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: AppColorTheme.black);
  static const regularGrey = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: AppColorTheme.grey);

  static const big = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.bold,
      fontSize: 30,
      color: AppColorTheme.mainColor);

  static const main = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.bold,
      fontSize: 40,
      color: AppColorTheme.mainColor);
}
