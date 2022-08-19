import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeMode type = ThemeMode.system;

  void changeType(ThemeMode newType) {
    type = newType;
    notifyListeners();
  }
}
