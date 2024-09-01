import 'package:domain/services/shared_preference_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preference_key_type.dart';

class SharedPreferenceServiceImpl implements SharedPreferenceService {
  late SharedPreferences _pref;

  @override
  Future<void> initialize() async {
    _pref = await SharedPreferences.getInstance();
  }

  @override
  int get themeIndex => _pref.getInt(PrefKeyType.themeSetting.name) ?? 0;
  @override
  set themeIndex(int value) =>
      _pref.setInt(PrefKeyType.themeSetting.name, value);
}
