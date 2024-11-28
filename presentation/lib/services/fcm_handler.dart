import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:presentation/push_notification/push_notification_data.dart';
import 'package:presentation/push_notification/push_notification_manager.dart';

@pragma('vm:entry-point')
Future<void> fcmBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    print("Notification Received!");
  }
}

Future<void> fcmForegroundHandler(RemoteMessage message) async {
  PushNotificationManager().showNotification(TempPushNotification());
}
