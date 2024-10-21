import 'package:domain/notification/usecases/fetch_notification_setting_hour.dart';
import 'package:presentation/common/base_viewmodel.dart';

class ExecutiveAlarmSettingViewModel extends BaseViewModel<> {
  final fetchNotificationSettingHour = FetchNotificationSettingHour();
  final alarmTime = 2;
}
