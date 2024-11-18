import 'package:domain/member/value_objects/member_part_type.dart';
import 'package:domain/notification/value_objects/notification_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preference_key_type.dart';

class SharedPreferenceLocalDatasource {
  late SharedPreferences _pref;

  Future<void> initialize() async {
    _pref = await SharedPreferences.getInstance();
  }

  int get themeIndex => _pref.getInt(PrefKeyType.themeSetting.name) ?? 0;
  set themeIndex(int value) =>
      _pref.setInt(PrefKeyType.themeSetting.name, value);

  bool isNotificationOn(NotificationType type) {
    return _pref.getBool(_getNotificationSettingOnKey(type).name) ?? true;
  }

  void setNotificationOn(NotificationType type, bool value) {
    _pref.setBool(_getNotificationSettingOnKey(type).name, value);
  }

  int getNotificationHour(NotificationType type) {
    return _pref.getInt(_getNotificationSettingHourKey(type).name) ?? 2;
  }

  void setNotificationHour(NotificationType type, int value) {
    _pref.setInt(_getNotificationSettingHourKey(type).name, value);
  }

  bool get isMocking => _pref.getBool(PrefKeyType.isMocking.name) ?? false;
  set isMocking(bool value) => _pref.setBool(PrefKeyType.isMocking.name, value);

  bool get isTestingEmptyData =>
      _pref.getBool(PrefKeyType.isTestingEmptyData.name) ?? false;
  set isTestingEmptyData(bool value) =>
      _pref.setBool(PrefKeyType.isTestingEmptyData.name, value);

  bool get isTestingException =>
      _pref.getBool(PrefKeyType.isTestingException.name) ?? false;
  set isTestingException(bool value) =>
      _pref.setBool(PrefKeyType.isTestingException.name, value);

  PrefKeyType _getNotificationSettingOnKey(NotificationType type) =>
      switch (type) {
        RegularMettingNotification() =>
          PrefKeyType.regularMettingNotificationSettingOn,
        PartMettingNotification partMetting => switch (partMetting.partType) {
            MemberPartType.design =>
              PrefKeyType.designPartMettingNotificationSettingOn,
            MemberPartType.development =>
              PrefKeyType.developPartMettingNotificationSettingOn,
            MemberPartType.art =>
              PrefKeyType.artPartMettingNotificationSettingOn,
          },
        FeeNotification() => PrefKeyType.feeNotificationSettingOn,
        CleaningNotification() => PrefKeyType.cleaningNotificationSettingOn,
        RentNotification() => PrefKeyType.rentNotificationSettingOn,
      };

  PrefKeyType _getNotificationSettingHourKey(NotificationType type) =>
      switch (type) {
        RegularMettingNotification() =>
          PrefKeyType.regularMettingNotificationSettingHour,
        PartMettingNotification partMetting => switch (partMetting.partType) {
            MemberPartType.design =>
              PrefKeyType.designPartMettingNotificationSettingHour,
            MemberPartType.development =>
              PrefKeyType.developPartMettingNotificationSettingHour,
            MemberPartType.art =>
              PrefKeyType.artPartMettingNotificationSettingHour,
          },
        FeeNotification() => throw UnimplementedError(),
        CleaningNotification() => throw UnimplementedError(),
        RentNotification() => throw UnimplementedError(),
      };
}
