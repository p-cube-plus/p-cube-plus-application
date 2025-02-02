import 'package:domain/fee/value_object/account_information.dart';

sealed class FeeSettingEvent {}

class ShowLoadingFeeSettingEvent extends FeeSettingEvent {}

class CloseLoadingFeeSettingEvent extends FeeSettingEvent {}

class ShowToastFeeSettingEvent extends FeeSettingEvent {
  final String message;
  ShowToastFeeSettingEvent(this.message);
}

class SuccessLoadFeeInfoFeeSettingEvent extends FeeSettingEvent {
  final AccountInformation accountInfo;
  SuccessLoadFeeInfoFeeSettingEvent(this.accountInfo);
}
