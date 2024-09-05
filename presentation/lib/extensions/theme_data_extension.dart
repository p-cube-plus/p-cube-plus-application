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

  Color get neutral20 =>
      (brightness == Brightness.light) ? color.lightGray20 : color.darkGray20;

  Color get neutral10 =>
      (brightness == Brightness.light) ? color.lightGray10 : color.darkGray10;
}

extension PrimaryExtension on ThemeData {
  Color get primary80 => (brightness == Brightness.light)
      ? color.lightPrimary80
      : color.darkPrimary80;

  Color get primary60 => (brightness == Brightness.light)
      ? color.lightPrimary60
      : color.darkPrimary60;

  Color get primary40 => (brightness == Brightness.light)
      ? color.lightPrimary40
      : color.darkPrimary40;

  Color get primary10 => (brightness == Brightness.light)
      ? color.lightPrimary10
      : color.darkPrimary10;
}

extension SecondaryExtension on ThemeData {
  Color get secondary120 => color.lightSecondary120;

  Color get secondary => (brightness == Brightness.light)
      ? color.lightSecondary
      : color.darkSecondary;

  Color get secondary20 => (brightness == Brightness.light)
      ? color.lightSecondary20
      : color.darkSecondary20;
}

extension YellowExtension on ThemeData {
  Color get yellow100 => color.yellow100;

  Color get yellow50 => (brightness == Brightness.light)
      ? color.lightYellow50
      : color.darkYellow50;
}
