import 'package:domain/notification/value_objects/regular_notification_data.dart';

class RegularNotificationSetting {
  final RegularNotificationData regularNotification;
  final Duration beforeMeetingTime;
  final String location;
  final bool isEnable;

  RegularNotificationSetting({
    required this.regularNotification,
    required this.beforeMeetingTime,
    required this.location,
    required this.isEnable,
  });
}
