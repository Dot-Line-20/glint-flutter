import 'package:firebase_getx_boilerplate/app/core/color_theme.dart';
import 'package:flutter/material.dart';

abstract class AppTextTheme {
  //Default Black
  //Name Rule
  //FontWeight + Color + Font Size

  static const extraBold22 = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.w800,
      fontSize: 22,
      color: AppColorTheme.mainColor);

  static const bold20 = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.w700,
      fontSize: 20,
      color: AppColorTheme.black);
  static const boldMain20 = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.w700,
      fontSize: 20,
      color: AppColorTheme.mainColor);

  static const boldGray18 = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.w700,
      fontSize: 18,
      color: AppColorTheme.grey);
  static const boldWhite14 = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.w700,
      fontSize: 14,
      color: AppColorTheme.white);
  static const boldGrey12 = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.w700,
      fontSize: 12,
      color: AppColorTheme.grey);

  static const regularGrey14 = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColorTheme.grey);
  static const regular20 = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.w400,
      fontSize: 20,
      color: AppColorTheme.black);
  static const regular12 = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: AppColorTheme.black);
  static const regularWhite12 = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: AppColorTheme.white);

  static const semiboldMain14 = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: AppColorTheme.mainColor);
  static const semiboldMain20 = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: AppColorTheme.mainColor);
  static const semiboldWhite22 = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.w600,
      fontSize: 22,
      color: AppColorTheme.white);
  static const semiboldGrey16 = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: AppColorTheme.grey);

  static const medium20 = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: AppColorTheme.black);
  static const medium16 = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: AppColorTheme.black);
  static const mediumGrey14 = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: AppColorTheme.grey);
  static const mediumWhite14 = TextStyle(
      fontFamily: "Pretendard",
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: AppColorTheme.white);
}
