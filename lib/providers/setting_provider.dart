import 'package:flutter/material.dart';

enum SettingType {
  Theme,
}

abstract class ISetting {
  void toggle(bool isOn);
  bool get isOn;
  dynamic get item;
}

class ThemeSetting implements ISetting {
  ThemeMode themeMode = ThemeMode.system;

  @override
  void toggle(bool isOn) => themeMode = isOn ? ThemeMode.light : ThemeMode.dark;

  @override
  bool get isOn => themeMode == ThemeMode.light;

  @override
  get item => themeMode;
}

class SettingProvider with ChangeNotifier {
  late ISetting curState;
  final theme = ThemeSetting();

  void changeState(SettingType type) {
    switch (type) {
      case SettingType.Theme:
        curState = theme;
        break;
      default:
    }
    notifyListeners();
  }

  void toggle(bool isOn) {
    curState.toggle(isOn);
    notifyListeners();
  }

  bool get isOn => curState.isOn;
  dynamic get item => curState.item;
}
