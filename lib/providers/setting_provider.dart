import 'package:flutter/material.dart';

enum SettingType {
  AllNotice,
  AllMeetingNotice,
  PartMeetingNotice,
  DuesNotice,
  CleanNotice,
  BookNotice,
}

abstract class ISetting {
  void toggle(bool isOn);
  bool get isOn;
  dynamic get item;
}

class NoticeAllSetting implements ISetting {
  bool flag = true;

  @override
  bool get isOn => flag;

  @override
  void toggle(bool isOn) => flag = isOn;

  @override
  get item => flag;
}

class NoticeSetting implements ISetting {
  bool flag = true;

  @override
  bool get isOn => flag;

  @override
  void toggle(bool isOn) => flag = isOn;

  @override
  get item => flag;
}

class SettingProvider with ChangeNotifier {
  late ISetting curState;
  final allNotice = NoticeAllSetting();
  final notices = List<NoticeSetting>.generate(5, (index) => NoticeSetting());

  void changeState(SettingType type) {
    switch (type) {
      case SettingType.AllNotice:
        curState = allNotice;
        break;
      case SettingType.AllMeetingNotice:
        curState = notices[0];
        break;
      case SettingType.PartMeetingNotice:
        curState = notices[1];
        break;
      case SettingType.DuesNotice:
        curState = notices[2];
        break;
      case SettingType.CleanNotice:
        curState = notices[3];
        break;
      case SettingType.BookNotice:
        curState = notices[4];
        break;
      default:
    }
  }

  void toggle(bool isOn) {
    curState.toggle(isOn);
    notifyListeners();
  }

  bool get isOn => curState.isOn;
  dynamic get item => curState.item;
}
