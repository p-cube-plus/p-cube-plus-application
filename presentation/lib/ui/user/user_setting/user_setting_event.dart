sealed class UserSettingEvent {}

class OnSuccessLogoutEvent extends UserSettingEvent {}

class DismissLoadingDialog extends UserSettingEvent {}

class ShowToastMessage extends UserSettingEvent {
  final String message;
  ShowToastMessage(this.message);
}
