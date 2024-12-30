import 'package:domain/notification/usecases/fetch_new_notification_use_case.dart';
import 'package:domain/notification/usecases/fetch_read_notification_use_case.dart';
import 'package:domain/notification/usecases/update_read_notification_use_case.dart';
import 'package:domain/notification/value_objects/notification_data.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/ui/alarm/alarm_event.dart';

class AlarmViewModel extends BaseViewModel<AlarmEvent> {
  final _fetchNewNotificationUseCase = FetchNewNotificationUseCase();
  final _fetchReadNotificationUseCase = FetchReadNotificationUseCase();
  final _updateReadNotificationUseCase = UpdateReadNotificationUseCase();

  List<NotificationData> newNotificationList = [];
  List<NotificationData> readNotificationList = [];

  AlarmViewModel() {
    Future.wait([
      _fetchNewNotificationUseCase(),
      _fetchReadNotificationUseCase(),
    ]).then((data) {
      newNotificationList = data.first;
      readNotificationList = data.last;
      notifyListeners();
      triggerEvent(AlarmEvent.dismissProgress);
    });
  }

  void updateReadNotification(int notificationId) async {
    triggerEvent(AlarmEvent.showProgress);
    _updateReadNotificationUseCase.call(notificationId).then((readData) {
      List<NotificationData> updatedNewNotificationList =
          List.from(newNotificationList);
      updatedNewNotificationList
          .removeWhere((data) => data.id == notificationId);

      newNotificationList = updatedNewNotificationList;
      readNotificationList = [readData, ...readNotificationList];
      notifyListeners();
      triggerEvent(AlarmEvent.dismissProgress);
    });
  }
}
