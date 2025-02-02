import 'package:domain/notification/usecases/fetch_notification_setting_use_case.dart';
import 'package:domain/notification/value_objects/notification_setting.dart';
import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:presentation/common/base_viewmodel.dart';

enum ExecutiveAlarmSettingState {
  showProgressDialog,
  dismissProgressDialog,
  popPage,
  setSettingText,
}

class ExecutiveAlarmSettingViewModel
    extends BaseViewModel<ExecutiveAlarmSettingState> {
  final _fetchNotificationSettingHourUseCase =
      FetchNotificationSettingUseCase();

  final NotificationType notificationType;
  late NotificationSetting setting;

  var _initSettingOn = false;
  var isSettingOn = false;
  var _initSettingHour = 0;
  var settingHour = 0;

  ExecutiveAlarmSettingViewModel({
    required this.notificationType,
  }) {
    fetchNotificationSetting();
  }

  void fetchNotificationSetting() async {
    setting = await _fetchNotificationSettingHourUseCase(notificationType)
        .then((data) {
      _initSettingOn = isSettingOn = data.isOn;
      _initSettingHour = settingHour = data.reminderHours;
      return data;
    });
    triggerEvent(ExecutiveAlarmSettingState.setSettingText);
    notifyListeners();
  }

  bool isEdited(int inputHour) {
    return _initSettingOn != isSettingOn || _initSettingHour != inputHour;
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
    _initSettingOn = isSettingOn;
    _initSettingHour = settingHour;
    triggerEvent(ExecutiveAlarmSettingState.dismissProgressDialog);
  }

  Future<void> saveSettingWithPopPage() async {
    await saveSetting();
    triggerEvent(ExecutiveAlarmSettingState.popPage);
  }
}
