import 'package:domain/common/extensions/future_extension.dart';
import 'package:domain/notification/usecases/fetch_notification_setting_use_case.dart';
import 'package:domain/notification/usecases/update_notification_setting_use_case.dart';
import 'package:domain/notification/value_objects/notification_setting.dart';
import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/ui/executive/alarm/executive_alarm_setting_event.dart';

class ExecutiveAlarmSettingViewModel
    extends BaseViewModel<ExecutiveAlarmSettingEvent> {
  final _fetchNotificationSettingHourUseCase =
      FetchNotificationSettingUseCase();

  final _updateNotificationSettingUseCase = UpdateNotificationSettingUseCase();

  final NotificationType notificationType;

  var isLoading = true;

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
    isLoading = true;
    final result = await _fetchNotificationSettingHourUseCase
        .call(notificationType)
        .getOrNull();

    if (result == null) {
      isLoading = false;
      notifyListeners();
      triggerEvent(ShowToastExecutiveAlarmSettingEvent("알림 설정 불러오기에 실패했습니다."));
      return;
    }

    isLoading = false;
    _initSettingOn = isSettingOn = result.isOn;
    _initSettingHour = settingHour = result.reminderHours;

    triggerEvent(SetSettingTextExecutiveAlarmSettingEvent(
        result.reminderHours.toString()));
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

  Future<bool> saveSetting(String reminderHours) async {
    if (isLoading) {
      triggerEvent(
          ShowToastExecutiveAlarmSettingEvent("저장실패! 아직 알림 데이터를 불러오지 못했습니다."));
      return false;
    }

    var isSuccess = false;
    triggerEvent(ShowProgressDialogExecutiveAlarmSettingEvent());

    await _updateNotificationSettingUseCase
        .call(NotificationSetting(
      type: notificationType,
      isOn: isSettingOn,
      reminderHours: int.parse(reminderHours),
    ))
        .then((v) {
      _initSettingOn = isSettingOn;
      _initSettingHour = settingHour;
      isSuccess = true;
    }).onFailure((e) {
      triggerEvent(ShowToastExecutiveAlarmSettingEvent("알림 설정 저장에 실패했습니다."));
    });

    triggerEvent(DismissProgressDialogExecutiveAlarmSettingEvent());
    triggerEvent(ShowToastExecutiveAlarmSettingEvent("현재 알림 설정을 저장했습니다."));
    return isSuccess;
  }

  Future<void> saveSettingWithPopPage(String reminderHours) async {
    final isSuccess = await saveSetting(reminderHours);
    if (isSuccess) {
      triggerEvent(PopPageExecutiveAlarmSettingEvent());
    }
  }
}
