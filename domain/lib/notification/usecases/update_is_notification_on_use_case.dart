import 'package:domain/notification/repository/notification_repository.dart';
import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:get_it/get_it.dart';

class UpdateIsNotificationOnUseCase {
  final _notificationRepository = GetIt.I.get<NotificationRepository>();

  Future<void> call(NotificationType type, bool isEnable) {
    return _notificationRepository.setNotificationEnable(type, isEnable);
  }
}
