import 'package:domain/notification/usecases/fetch_new_notification_use_case.dart';
import 'package:domain/notification/usecases/fetch_read_notification_use_case.dart';
import 'package:domain/notification/usecases/update_read_notification_use_case.dart';
import 'package:domain/notification/value_objects/notification_data.dart';
import 'package:presentation/common/base_viewmodel.dart';

class AlarmViewModel extends BaseViewModel<void, void> {
  final _fetchNewNotificationUseCase = FetchNewNotificationUseCase();
  final _fetchReadNotificationUseCase = FetchReadNotificationUseCase();
  final _updateReadNotificationUseCase = UpdateReadNotificationUseCase();

  List<NotificationData> newNotificationList = [];
  List<NotificationData> readNotificationList = [];

  Future<List<NotificationData>> fetchNewNotification() =>
      _fetchNewNotificationUseCase();

  Future<List<NotificationData>> fetchReadNotification() =>
      _fetchReadNotificationUseCase();

  void updateReadNotification(int notificationId) async {
    _updateReadNotificationUseCase
        .call(notificationId)
        .then((_) => notifyListeners());
  }
}
