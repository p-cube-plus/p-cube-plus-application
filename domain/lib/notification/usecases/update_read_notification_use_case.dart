import 'package:domain/notification/repository/notification_repository.dart';
import 'package:domain/notification/value_objects/notification_data.dart';
import 'package:get_it/get_it.dart';

class UpdateReadNotificationUseCase {
  final _notificationRepository = GetIt.I.get<NotificationRepository>();

  Future<NotificationData> call(int id) {
    return _notificationRepository.updateNotificationAsRead(id);
  }
}
