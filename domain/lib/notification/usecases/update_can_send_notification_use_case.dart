import 'package:domain/notification/repository/notification_repository.dart';
import 'package:get_it/get_it.dart';

class UpdateCanSendNotificationUseCase {
  final _notificationRepository = GetIt.I.get<NotificationRepository>();

  Future<void> call(bool canSendNotification) {
    return _notificationRepository.setCanSendNotification(canSendNotification);
  }
}
