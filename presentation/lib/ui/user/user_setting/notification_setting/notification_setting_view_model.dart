import 'package:domain/common/extensions/future_extension.dart';
import 'package:domain/notification/usecases/fetch_can_send_notification_use_case.dart';
import 'package:domain/notification/usecases/fetch_is_notification_on_use_case.dart';
import 'package:domain/notification/usecases/update_can_send_notification_use_case.dart';
import 'package:domain/notification/usecases/update_is_notification_on_use_case.dart';
import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:presentation/common/base_viewmodel.dart';

class NotificationSettingViewModel extends BaseViewModel<void> {
  final _fetchCanSendNotificationUseCase = FetchCanSendNotificationUseCase();
  final _updateCanSendNotificationUseCase = UpdateCanSendNotificationUseCase();

  final _fetchIsNotificationOnUseCase = FetchIsNotificationOnUseCase();
  final _updateIsNotificationOnUseCase = UpdateIsNotificationOnUseCase();

  Future<bool> fetchCanSendNotification() =>
      _fetchCanSendNotificationUseCase().getOrDefault(true);

  void updateCanSendNotification(bool canSend) {
    _updateCanSendNotificationUseCase(canSend).getOrNull();
  }

  Future<bool> fetchIsNotificationOn(NotificationType type) =>
      _fetchIsNotificationOnUseCase(type).getOrDefault(true);

  void updateIsNotificationOnUseCase(NotificationType type, bool isEnable) {
    _updateIsNotificationOnUseCase(type, isEnable).getOrNull();
  }
}
