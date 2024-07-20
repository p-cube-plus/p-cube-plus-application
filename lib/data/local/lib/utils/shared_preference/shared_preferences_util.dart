import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preference_key_type.dart';

class SharedPreferencesUtil {
  SharedPreferencesUtil._internal();
  static final _instance = SharedPreferencesUtil._internal();
  factory SharedPreferencesUtil() => _instance;

  late SharedPreferences _pref;

  Future<void> initialize() async {
    _pref = await SharedPreferences.getInstance();
  }

  int get themeIndex => _pref.getInt(PrefKeyType.themeSetting.name) ?? 0;
  set themeIndex(int value) =>
      _pref.setInt(PrefKeyType.themeSetting.name, value);
}
