import 'package:domain/app_setting/models/theme_type.dart';
import 'package:domain/app_setting/repository/app_setting_repository.dart';
import 'package:domain/notification/models/notification_type.dart';

class AppSettingRepositoryImpl implements AppSettingRepository {
  // var cache2 = <(int year, int month), MemoryCache<List<int>>>{};

  // void schedule(int year, int month, {bool isForce = false}) {
  //   if (isForce) {
  //     cache2.clear();
  //   }
  //   if (!cache2.keys.any((key) => year == key.$1 && month == key.$2)) {
  //     cache2[(year, month)] = MemoryCache<List<int>>();
  //   }
  //   cache2[(year, month)].get();
  // }

  @override
  Future<bool> getNotificationEnable(NotificationType type) {
    throw UnimplementedError();
  }

  @override
  Future<ThemeType> getTheme() {
    // TODO: implement getTheme
    throw UnimplementedError();
  }

  @override
  Future<void> initAppSetting() {
    // TODO: implement initAppSetting
    throw UnimplementedError();
  }

  @override
  Future<void> setAllNotificationEnable(bool isEnable) {
    // TODO: implement setAllNotificationEnable
    throw UnimplementedError();
  }

  @override
  Future<void> setNotificationEnable(NotificationType type, bool isEnable) {
    // TODO: implement setNotificationEnable
    throw UnimplementedError();
  }

  @override
  Future<void> setTheme(ThemeType themeType) {
    // TODO: implement setTheme
    throw UnimplementedError();
  }
}
