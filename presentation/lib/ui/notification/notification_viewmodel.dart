import 'package:domain/common/extensions/future_extension.dart';
import 'package:domain/notification/usecases/fetch_new_notification_use_case.dart';
import 'package:domain/notification/usecases/fetch_read_notification_use_case.dart';
import 'package:domain/notification/usecases/update_read_notification_use_case.dart';
import 'package:domain/notification/value_objects/notification_data.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/ui/notification/notification_event.dart';

class NotificationViewModel extends BaseViewModel<NotificationEvent> {
  final _fetchNewNotificationUseCase = FetchNewNotificationUseCase();
  final _fetchReadNotificationUseCase = FetchReadNotificationUseCase();
  final _updateReadNotificationUseCase = UpdateReadNotificationUseCase();

  List<(bool isReading, NotificationData)> newNotificationList = [];
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
      triggerEvent(NotificationEvent.showDataErrorToast);
    } else {
      newNotificationList = data.first.map((e) => (false, e)).toList();
      readNotificationList = data.last;
    }

    notifyListeners();
  }

  void updateReadNotification(int index) async {
    final notificationId = newNotificationList[index].$2.id;

    newNotificationList = newNotificationList
        .map((item) => item.$2.id == notificationId ? (true, item.$2) : item)
        .toList();
    notifyListeners();

    final readData =
        await _updateReadNotificationUseCase.call(notificationId).getOrNull();

    if (readData == null) {
      triggerEvent(NotificationEvent.showErrorToast);
      return;
    }

    final updatedNewNotificationList =
        List<(bool, NotificationData)>.from(newNotificationList);
    updatedNewNotificationList
        .removeWhere((data) => data.$2.id == notificationId);

    newNotificationList = updatedNewNotificationList;
    readNotificationList = [readData, ...readNotificationList];
    notifyListeners();
  }
}
