import 'package:domain/notification/value_objects/notification_data.dart';
import 'package:domain/notification/value_objects/notification_setting.dart';
import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:domain/notification/value_objects/regular_notification_data.dart';
import 'package:domain/notification/value_objects/regular_notification_setting.dart';

abstract interface class NotificationRepository {
  Future<List<NotificationData>> getNotificationList();

  Future<void> setNotification(
    NotificationType type,
    bool isEnable,
    DateTime beforeMeetingTime,
  );

  Future<List<RegularNotificationData>> getRegularNotification(
    PartMettingNotification type,
  );

  Future<void> setRegularNotification(
    RegularNotificationSetting setting,
  );

  Future<void> setNotificationAllEnable(bool isEnable);
  Future<void> setNotificationEnable(NotificationType type, bool isEnable);

  Future<NotificationData> updateNotificationAsRead(int id);

  Future<NotificationSetting> fetchNotificationSetting(NotificationType type);
}
