import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/local/lib/shared_preferences_util.dart';

class SharedViewModel with ChangeNotifier {
  Future<ThemeMode> getTheme() async {
    return await SharedPreferencesUtil().getThemeMode();
  }

  Future<void> setTheme(ThemeMode newTheme) async {
    await SharedPreferencesUtil().setThemeMode(newTheme);
    notifyListeners();
  }
}
