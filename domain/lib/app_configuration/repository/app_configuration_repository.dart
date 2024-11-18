import '../value_objects/theme_type.dart';

/// 앱 전체에 적용되는 데이터들의 저장소
abstract interface class AppConfigurationRepository {
  Future<void> initializeOnSplashStart();

  ThemeType getTheme();
  void setTheme(ThemeType themeType);
}
