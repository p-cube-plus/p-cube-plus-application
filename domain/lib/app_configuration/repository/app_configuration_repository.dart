import '../value_objects/theme_type.dart';

abstract interface class AppConfigurationRepository {
  ThemeType getTheme();
  void setTheme(ThemeType themeType);
}
