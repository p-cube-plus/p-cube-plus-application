enum PushNotificationType {
  test(1),
  test2(2),
  test3(3),
  ;

  const PushNotificationType(this.notificationId);
  final int notificationId;
}

class PushNotificationData {
  final PushNotificationType type;
  final String title;
  final String descrption;
  const PushNotificationData({
    required this.type,
    required this.title,
    required this.descrption,
  });
}
