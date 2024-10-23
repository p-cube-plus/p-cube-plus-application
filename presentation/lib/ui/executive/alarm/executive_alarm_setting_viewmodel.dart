import 'package:domain/notification/usecases/fetch_notification_setting_hour_use_case.dart';
import 'package:domain/notification/usecases/fetch_notification_setting_on_use_case.dart';
import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:presentation/common/base_viewmodel.dart';

enum ExecutiveAlarmSettingEvent {
  saveSetting,
  saveSettingWithPopPage,
  saveSettingOn,
}

enum ExecutiveAlarmSettingState {
  showProgressDialog,
  dismissProgressDialog,
  popPage,
}

class ExecutiveAlarmSettingViewModel extends BaseViewModel<
    ExecutiveAlarmSettingEvent, ExecutiveAlarmSettingState> {
  final _fetchNotificationSettingHourUseCase =
      FetchNotificationSettingHourUseCase();
  final _fetchNotificationSettingOnUseCase =
      FetchNotificationSettingOnUseCase();

  final NotificationType notificationType;

  var initSettingOn = false;
  var isSettingOn = false;
  var initSettingHour = 0;

  ExecutiveAlarmSettingViewModel({
    required this.notificationType,
  }) {
    eventStream.listen((event) {
      switch (event) {
        case ExecutiveAlarmSettingEvent.saveSetting:
          _saveSetting();
        case ExecutiveAlarmSettingEvent.saveSettingWithPopPage:
          _saveSettingWithPopPage();
        case ExecutiveAlarmSettingEvent.saveSettingOn:
          _setSettingOn(event.isOn);
      }
    });
  }

  Future<bool> fetchNotificationSettingOn() =>
      _fetchNotificationSettingOnUseCase(notificationType).then((isOn) {
        initSettingOn = isOn;
      });

  Future<int> fetchNotificationSettingHour() =>
      _fetchNotificationSettingHourUseCase(notificationType)
          .then((hour) => initSettingHour = hour);

  bool isEdited(int inputHour) {
    return initSettingOn != isSettingOn || initSettingHour != inputHour;
  }

  void _setSettingOn(bool isOn) {
    isSettingOn = isOn;
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
