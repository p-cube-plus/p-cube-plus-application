import 'package:data/source/local/setting_data_source.dart';
import 'package:local/utils/shared_preference/shared_preferences_util.dart';

class SettingsDataSourceImpl implements SettingDataSource {
  final util = SharedPreferencesUtil();

  @override
  int getThemeModeIndex() => util.themeIndex;

  @override
  void setThemeModeIndex(int value) => util.themeIndex = value;
}
