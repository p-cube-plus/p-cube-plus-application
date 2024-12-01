import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:presentation/push_notification/push_notification_data.dart';
import 'package:presentation/push_notification/push_notification_manager.dart';

@pragma('vm:entry-point')
Future<void> fcmHandler(RemoteMessage message) async {
  if (Platform.isAndroid) {
    var data = message.data;
    final type = PushNotificationType.values.byName(data["type"] as String);
    final title = data["title"];
    final desception = data["desception"];

    PushNotificationManager().showNotification(
      PushNotificationData(
        type: type,
        title: title,
        descrption: desception,
      ),
      payload: _getPayload(type),
    );
  } else if (Platform.isIOS) {
    if (message.notification != null) return;
  }
}

String? _getPayload(PushNotificationType type) {
  return switch (type) {
    PushNotificationType.test => "/login/developer",
    PushNotificationType.test2 => "/alarm",
    PushNotificationType.test3 => "/user",
  };
}
