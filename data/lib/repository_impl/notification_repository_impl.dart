import 'package:domain/notification/repository/notification_repository.dart';
import 'package:domain/notification/value_objects/notification_data.dart';
import 'package:domain/notification/value_objects/notification_setting.dart';
import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:domain/notification/value_objects/regular_notification_data.dart';
import 'package:domain/notification/value_objects/regular_notification_setting.dart';

class NotificationRepositoryImpl implements NotificationRepository {
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
  Future<NotificationSetting> fetchNotificationSetting(NotificationType type) {
    // TODO: implement fetchNotificationSetting
    throw UnimplementedError();
  }

  @override
  Future<List<NotificationData>> getNotificationList() {
    // TODO: implement getNotificationList
    throw UnimplementedError();
  }

  @override
  Future<NotificationData> updateNotificationAsRead(int id) {
    // TODO: implement updateNotificationAsRead
    throw UnimplementedError();
  }
}
