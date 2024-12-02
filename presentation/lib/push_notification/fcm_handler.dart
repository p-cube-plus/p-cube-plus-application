import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:presentation/push_notification/push_notification_data.dart';
import 'package:presentation/route_handler/route_type.dart';

@pragma('vm:entry-point')
Future<void> fcmHandler(RemoteMessage message) async {
  if (message.notification == null) return;
}

RouteType getPayload(Map<String, dynamic> fcmMessageData) {
  final type =
      PushNotificationType.values.byName(fcmMessageData["type"] as String);
  return switch (type) {
    PushNotificationType.test => RouteType.alarm,
    PushNotificationType.test2 => RouteType.home,
    PushNotificationType.test3 => RouteType.user,
  };
}
