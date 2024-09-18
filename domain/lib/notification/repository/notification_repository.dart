import 'package:domain/notification/models/notification_data.dart';

abstract interface class NotificationRepository {
  Future<List<NotificationData>> getNotificationList();
}
