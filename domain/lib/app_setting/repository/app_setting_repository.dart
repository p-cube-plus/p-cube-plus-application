import 'package:domain/notification/models/notification_type.dart';

import '../models/theme_type.dart';

abstract class AppSettingRepository {
  Future<void> initAppSetting();

  Future<ThemeType> getTheme();
  Future<void> setTheme(ThemeType themeType);

  Future<void> setAllNotificationEnable(bool isEnable);
  Future<void> setNotificationEnable(NotificationType type, bool isEnable);
  Future<bool> getNotificationEnable(NotificationType type);
}
