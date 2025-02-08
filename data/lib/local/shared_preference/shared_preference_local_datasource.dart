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

  bool get canSendNotification =>
      _pref.getBool(PrefKeyType.canSendNotificationSetting.name) ?? true;
  set canSendNotification(bool value) =>
      _pref.setBool(PrefKeyType.canSendNotificationSetting.name, value);

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

  double get mockDelay => _pref.getDouble(PrefKeyType.mockDelay.name) ?? 1.0;
  set mockDelay(double value) =>
      _pref.setDouble(PrefKeyType.mockDelay.name, value);

  bool get isTestingException =>
      _pref.getBool(PrefKeyType.isTestingException.name) ?? false;
  set isTestingException(bool value) =>
      _pref.setBool(PrefKeyType.isTestingException.name, value);

  bool get isShowOnlyActiveMember =>
      _pref.getBool(PrefKeyType.isShowOnlyActiveMember.name) ?? false;
  set isShowOnlyActiveMember(bool value) =>
      _pref.setBool(PrefKeyType.isShowOnlyActiveMember.name, value);

  int get memberNameSortType =>
      _pref.getInt(PrefKeyType.memberNameSortType.name) ?? 0;
  set memberNameSortType(int value) =>
      _pref.setInt(PrefKeyType.memberNameSortType.name, value);

  PrefKeyType _getNotificationSettingOnKey(NotificationType type) =>
      switch (type) {
        RegularMettingNotification() =>
          PrefKeyType.regularMettingNotificationSettingOn,
        PartMettingNotification() =>
          PrefKeyType.partMettingNotificationSettingOn,
        FeeNotification() => PrefKeyType.feeNotificationSettingOn,
        CleaningNotification() => PrefKeyType.cleaningNotificationSettingOn,
        RentNotification() => PrefKeyType.rentNotificationSettingOn,
        TestNotification() => throw UnimplementedError(),
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
            null => throw UnimplementedError(),
          },
        FeeNotification() => throw UnimplementedError(),
        CleaningNotification() => throw UnimplementedError(),
        RentNotification() => throw UnimplementedError(),
        TestNotification() => throw UnimplementedError(),
      };
}
