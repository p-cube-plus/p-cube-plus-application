import 'package:domain/notification/repository/notification_repository.dart';
import 'package:get_it/get_it.dart';

class FetchNotificationSettingHour {
  final _notificationRepository = GetIt.I.get<NotificationRepository>();

  Future<int> call() {
    return _notificationRepository.fetchNotificationSettingHour();
  }
}
