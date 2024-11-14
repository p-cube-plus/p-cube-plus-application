import 'package:domain/notification/repository/notification_repository.dart';
import 'package:domain/notification/value_objects/notification_data.dart';
import 'package:get_it/get_it.dart';

class FetchReadNotificationUseCase {
  final _notificationRepository = GetIt.I.get<NotificationRepository>();

  Future<List<NotificationData>> call() {
    return _notificationRepository.getNotificationList().then(
          (value) => value.where((data) => data.isRead).toList(),
        );
  }
}
