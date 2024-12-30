import 'package:domain/notification/usecases/fetch_notification_setting_use_case.dart';
import 'package:domain/notification/value_objects/notification_setting.dart';
import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:presentation/common/base_viewmodel.dart';

enum ExecutiveAlarmSettingState {
  showProgressDialog,
  dismissProgressDialog,
  popPage,
}

class ExecutiveAlarmSettingViewModel
    extends BaseViewModel<ExecutiveAlarmSettingState> {
  final _fetchNotificationSettingHourUseCase =
      FetchNotificationSettingUseCase();

  final NotificationType notificationType;

  var initSettingOn = false;
  var isSettingOn = false;
  var initSettingHour = 0;
  var settingHour = 0;

  ExecutiveAlarmSettingViewModel({
    required this.notificationType,
  });

  Future<NotificationSetting> fetchNotificationSetting() =>
      _fetchNotificationSettingHourUseCase(notificationType).then((data) {
        initSettingOn = isSettingOn = data.isOn;
        initSettingHour = settingHour = data.reminderHours;
        return data;
      });

  bool isEdited(int inputHour) {
    return initSettingOn != isSettingOn || initSettingHour != inputHour;
  }

  void setSettingOn(bool isOn) {
    isSettingOn = isOn;
    notifyListeners();
  }

  void setSettingHour(int hour) {
    settingHour = hour;
  }

  Future<void> saveSetting() async {
    triggerEvent(ExecutiveAlarmSettingState.showProgressDialog);
    // save
    await Future.delayed(Duration(seconds: 2));

    //success
    initSettingOn = isSettingOn;
    initSettingHour = settingHour;
    triggerEvent(ExecutiveAlarmSettingState.dismissProgressDialog);
  }

  Future<void> saveSettingWithPopPage() async {
    await saveSetting();
    triggerEvent(ExecutiveAlarmSettingState.popPage);
  }
}
