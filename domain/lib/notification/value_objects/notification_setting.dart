import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:meta/meta.dart';

@immutable
class NotificationSetting {
  final NotificationType type;
  final bool isOn;
  final int reminderHours;
  const NotificationSetting({
    required this.type,
    required this.isOn,
    required this.reminderHours,
  });
}
