import 'package:domain/notification/repository/notification_repository.dart';
import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:get_it/get_it.dart';

class FetchIsNotificationOnUseCase {
  final _notificationRepository = GetIt.I.get<NotificationRepository>();

  Future<bool> call(NotificationType type) {
    return _notificationRepository.getNotificationEnable(type);
  }
}
