import 'package:presentation/push_notification/push_notification_manager.dart';

Future initPushNotification() async {
  return PushNotificationManager().initialize();
}
