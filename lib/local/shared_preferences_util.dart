import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  SharedPreferencesUtil._internal();
  static final _instance = SharedPreferencesUtil._internal();
  factory SharedPreferencesUtil() => _instance;

  SharedPreferences? _pref;
  Future<SharedPreferences> get pref async =>
      _pref ?? await SharedPreferences.getInstance();

  final String themeSettingKey = "themeSettingKey";

  Future<ThemeMode> getThemeMode() async {
    var themeIndex =
        (await pref).getInt(themeSettingKey) ?? ThemeMode.system.index;
    return ThemeMode.values
        .firstWhere((element) => element.index == themeIndex);
  }

  Future<void> setThemeMode(ThemeMode value) async {
    (await pref).setInt(themeSettingKey, value.index);
  }
}
