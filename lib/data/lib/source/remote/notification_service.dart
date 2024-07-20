import 'package:data/models/remote/notification/notification_dto.dart';

abstract class NotificationService {
  Future<List<NotificationDTO>> getNotificationList();
}
