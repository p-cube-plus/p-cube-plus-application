import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:presentation/push_notification/push_notification_data.dart';

@pragma('vm:entry-point')
Future<void> fcmHandler(RemoteMessage message) async {
  if (message.notification == null) return;
}

String getPayload(Map<String, dynamic> fcmMessageData) {
  final type =
      PushNotificationType.values.byName(fcmMessageData["type"] as String);
  return switch (type) {
    PushNotificationType.test => "/developer",
    PushNotificationType.test2 => "/alarm",
    PushNotificationType.test3 => "/user",
  };
}
