import 'package:flutter/material.dart';
import 'package:presentation/constants/app_color.dart' as color;

extension TextThemeExtension on ThemeData {
  Color get neutral100 =>
      (brightness == Brightness.light) ? color.lightGray100 : color.darkGray100;

  Color get neutral80 =>
      (brightness == Brightness.light) ? color.lightGray80 : color.darkGray80;

  Color get neutral60 =>
      (brightness == Brightness.light) ? color.lightGray60 : color.darkGray60;

  Color get neutral40 =>
      (brightness == Brightness.light) ? color.lightGray40 : color.darkGray40;

  Color get neutral10 =>
      (brightness == Brightness.light) ? color.lightGray10 : color.darkGray10;
}
