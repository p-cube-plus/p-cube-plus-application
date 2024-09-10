import 'package:domain/notification/models/notification_data.dart';

abstract class NotificationRepository {
  Future<List<NotificationData>> getNotificationList();
}
