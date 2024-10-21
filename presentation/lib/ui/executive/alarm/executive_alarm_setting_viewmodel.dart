import 'package:domain/notification/usecases/fetch_notification_setting_hour.dart';
import 'package:presentation/common/base_viewmodel.dart';

class ExecutiveAlarmSettingViewModel extends BaseViewModel<void, void> {
  final fetchNotificationSettingHour = FetchNotificationSettingHour();
  final fetchNotificationSettingOn = FetchNotificationSettingOn();
}
