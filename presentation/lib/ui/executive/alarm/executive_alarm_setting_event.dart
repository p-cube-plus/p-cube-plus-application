sealed class ExecutiveAlarmSettingEvent {}

class ShowProgressDialogExecutiveAlarmSettingEvent
    extends ExecutiveAlarmSettingEvent {}

class DismissProgressDialogExecutiveAlarmSettingEvent
    extends ExecutiveAlarmSettingEvent {}

class PopPageExecutiveAlarmSettingEvent extends ExecutiveAlarmSettingEvent {}

class SetSettingTextExecutiveAlarmSettingEvent
    extends ExecutiveAlarmSettingEvent {
  final String reminderHours;
  SetSettingTextExecutiveAlarmSettingEvent(this.reminderHours);
}

class ShowToastExecutiveAlarmSettingEvent extends ExecutiveAlarmSettingEvent {
  final String message;
  ShowToastExecutiveAlarmSettingEvent(this.message);
}
