// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:glint/app/core/theme/color_theme.dart';

const Widget LOADINGINDICATOR = Center(
    child: CircularProgressIndicator(
  color: AppColorTheme.BUTTON1,
  backgroundColor: AppColorTheme.white,
  strokeWidth: 2,
));
