import 'package:data/local/shared_preference/shared_preference_local_datasource.dart';
import 'package:domain/notification/repository/notification_repository.dart';
import 'package:domain/notification/value_objects/notification_data.dart';
import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:domain/notification/value_objects/regular_notification_data.dart';
import 'package:domain/notification/value_objects/regular_notification_setting.dart';
import 'package:get_it/get_it.dart';

class MockNotificationRepositoryImpl implements NotificationRepository {
  final sharedPreferenceLocalDatasource =
      GetIt.I.get<SharedPreferenceLocalDatasource>();

  @override
  Future<List<NotificationData>> getNewNotificationList() {
    // TODO: implement getNewNotificationList
    throw UnimplementedError();
  }

  @override
  Future<List<NotificationData>> getReadNotificationList() {
    // TODO: implement getReadNotificationList
    throw UnimplementedError();
  }

  @override
  Future<List<RegularNotificationData>> getRegularNotification(
      PartMettingNotification type) {
    // TODO: implement getRegularNotification
    throw UnimplementedError();
  }

  @override
  Future<void> setNotification(
      NotificationType type, bool isEnable, DateTime beforeMeetingTime) {
    // TODO: implement setNotification
    throw UnimplementedError();
  }

  @override
  Future<void> setNotificationAllEnable(bool isEnable) {
    // TODO: implement setNotificationAllEnable
    throw UnimplementedError();
  }

  @override
  Future<void> setNotificationEnable(NotificationType type, bool isEnable) {
    // TODO: implement setNotificationEnable
    throw UnimplementedError();
  }

  @override
  Future<void> setRegularNotification(RegularNotificationSetting setting) {
    // TODO: implement setRegularNotification
    throw UnimplementedError();
  }

  @override
  Future<int> fetchNotificationSettingHour(NotificationType type) {
    return Future.value(
        sharedPreferenceLocalDatasource.getNotificationHour(type));
  }

  @override
  Future<bool> fetchNotificationSettingOn(NotificationType type) {
    return Future.value(sharedPreferenceLocalDatasource.isNotificationOn(type));
  }
}
