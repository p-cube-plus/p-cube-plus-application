import 'package:domain/attendance/value_objects/beacon_information.dart';

sealed class BeaconSettingEvent {}

class ShowLoadingBeaconSettingEvent extends BeaconSettingEvent {}

class CloseLoadingBeaconSettingEvent extends BeaconSettingEvent {}

class ShowToastBeaconSettingEvent extends BeaconSettingEvent {
  final String message;
  ShowToastBeaconSettingEvent(this.message);
}

class SuccessLoadBeaconInfoBeaconSettingEvent extends BeaconSettingEvent {
  final BeaconInformation beaconInfo;
  SuccessLoadBeaconInfoBeaconSettingEvent(this.beaconInfo);
}
