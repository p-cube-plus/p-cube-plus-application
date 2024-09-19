import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:meta/meta.dart';

@immutable
class NotificationData {
  final int id;
  final NotificationType type;
  final DateTime date;
  final String title;
  final String description;

  const NotificationData({
    required this.id,
    required this.type,
    required this.date,
    required this.title,
    required this.description,
  });
}
