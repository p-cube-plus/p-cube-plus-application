import 'package:domain/notification/repository/notification_repository.dart';
import 'package:get_it/get_it.dart';

class FetchCanSendNotificationUseCase {
  final _notificationRepository = GetIt.I.get<NotificationRepository>();

  Future<bool> call() {
    return _notificationRepository.getCanSendNotification();
  }
}
