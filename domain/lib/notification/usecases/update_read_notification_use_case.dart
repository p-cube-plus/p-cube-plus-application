import 'package:domain/notification/repository/notification_repository.dart';
import 'package:get_it/get_it.dart';

class UpdateReadNotificationUseCase {
  final _notificationRepository = GetIt.I.get<NotificationRepository>();

  Future<void> call(int id) {
    return _notificationRepository.updateNotificationAsRead();
  }
}
