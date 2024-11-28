sealed class PushNotificationData {
  abstract final int id;
  abstract final String title;
  abstract final String descrption;
}

class TempPushNotification implements PushNotificationData {
  @override
  int get id => 0;
  @override
  String get descrption => "테스트 알림입니다.";
  @override
  String get title => "테스트 알림";
}
