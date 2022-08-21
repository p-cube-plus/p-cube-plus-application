import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode type = ThemeMode.system;

  void changeType(ThemeMode newType) {
    type = newType;
    notifyListeners();
  }
}
