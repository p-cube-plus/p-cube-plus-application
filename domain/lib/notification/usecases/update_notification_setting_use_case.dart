import 'package:domain/notification/repository/notification_repository.dart';
import 'package:domain/notification/value_objects/notification_setting.dart';
import 'package:get_it/get_it.dart';

class UpdateNotificationSettingUseCase {
  final _notificationRepository = GetIt.I.get<NotificationRepository>();

  Future<void> call(NotificationSetting setting) {
    return _notificationRepository.setNotificationSetting(setting);
  }
}
