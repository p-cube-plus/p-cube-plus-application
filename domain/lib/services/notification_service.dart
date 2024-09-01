import 'package:domain/models/notification/notification_data.dart';

abstract class NotificationService {
  Future<List<NotificationData>> getNotificationList();
}
