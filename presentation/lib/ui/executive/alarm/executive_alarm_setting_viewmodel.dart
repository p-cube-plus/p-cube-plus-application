import 'package:domain/notification/usecases/fetch_notification_setting_use_case.dart';
import 'package:domain/notification/value_objects/notification_setting.dart';
import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:presentation/common/base_viewmodel.dart';

enum ExecutiveAlarmSettingEvent {
  saveSetting,
  saveSettingWithPopPage,
}

enum ExecutiveAlarmSettingState {
  showProgressDialog,
  dismissProgressDialog,
  popPage,
}

class ExecutiveAlarmSettingViewModel extends BaseViewModel<
    ExecutiveAlarmSettingEvent, ExecutiveAlarmSettingState> {
  final _fetchNotificationSettingHourUseCase =
      FetchNotificationSettingUseCase();

  final NotificationType notificationType;

  var initSettingOn = false;
  var isSettingOn = false;
  var initSettingHour = 0;
  var settingHour = 0;

  ExecutiveAlarmSettingViewModel({
    required this.notificationType,
  }) {
    eventStream.listen((event) {
      switch (event) {
        case ExecutiveAlarmSettingEvent.saveSetting:
          _saveSetting();
        case ExecutiveAlarmSettingEvent.saveSettingWithPopPage:
          _saveSettingWithPopPage();
      }
    });
  }

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

  Future<void> _saveSetting() async {
    triggerUiEvent(ExecutiveAlarmSettingState.showProgressDialog);
    // save
    await Future.delayed(Duration(seconds: 2));

    //success
    initSettingOn = isSettingOn;
    initSettingHour = settingHour;
    triggerUiEvent(ExecutiveAlarmSettingState.dismissProgressDialog);
  }

  Future<void> _saveSettingWithPopPage() async {
    await _saveSetting();
    triggerUiEvent(ExecutiveAlarmSettingState.popPage);
  }
}
