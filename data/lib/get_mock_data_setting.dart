import 'package:data/local/shared_preference/shared_preference_key_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future getMockDataSetting() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getBool(PrefKeyType.isMocking.name) ?? false;
}
