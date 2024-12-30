import 'package:flutter/material.dart';

extension BrightnessExtension on Brightness {
  Brightness get inverted {
    return this == Brightness.light ? Brightness.dark : Brightness.light;
  }
}
