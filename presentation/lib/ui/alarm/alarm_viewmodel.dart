import 'package:domain/common/extensions/future_extension.dart';
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

  bool isLoading = false;

  void fetchNotificationList() async {
    isLoading = true;
    notifyListeners();

    final data = await Future.wait([
      _fetchNewNotificationUseCase(),
      _fetchReadNotificationUseCase(),
    ]).getOrNull();

    isLoading = false;

    if (data == null) {
      triggerEvent(AlarmEvent.showDataErrorToast);
    } else {
      newNotificationList = data.first;
      readNotificationList = data.last;
    }

    notifyListeners();
  }

  void updateReadNotification(int notificationId) async {
    triggerEvent(AlarmEvent.showProgress);

    final readData =
        await _updateReadNotificationUseCase.call(notificationId).getOrNull();
    triggerEvent(AlarmEvent.dismissProgress);

    if (readData == null) {
      triggerEvent(AlarmEvent.showErrorToast);
      return;
    }

    final updatedNewNotificationList =
        List<NotificationData>.from(newNotificationList);
    updatedNewNotificationList.removeWhere((data) => data.id == notificationId);

    newNotificationList = updatedNewNotificationList;
    readNotificationList = [readData, ...readNotificationList];
    notifyListeners();
  }
}
