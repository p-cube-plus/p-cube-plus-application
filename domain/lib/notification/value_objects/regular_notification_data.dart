import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:meta/meta.dart';

@immutable
class RegularNotificationData {
  final String id;
  final NotificationType type;
  const RegularNotificationData({
    required this.id,
    required this.type,
  });
}
