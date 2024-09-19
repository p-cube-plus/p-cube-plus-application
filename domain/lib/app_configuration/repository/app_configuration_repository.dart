import '../value_objects/theme_type.dart';

/// 앱 전체에 적용되는 데이터들의 저장소
abstract interface class AppConfigurationRepository {
  /// 앱 실행 시 단 1번 필요한 초기화 작업
  Future<void> initialize();

  ThemeType getTheme();
  void setTheme(ThemeType themeType);
}
