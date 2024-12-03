import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'push_notification_data.dart';
import 'package:presentation/route_handler/route_handler.dart';

class PushNotificationManager {
  static final _instance = PushNotificationManager._internal();
  PushNotificationManager._internal();
  factory PushNotificationManager() => _instance;

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    final initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationReceived,
      onDidReceiveBackgroundNotificationResponse: onNotificationReceived,
    );
  }

  Future<void> showNotification(
    PushNotificationData data, {
    String? payload,
  }) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'NORMAL_CHANNEL', // Android\app\res\values\notification_channel_string.xml
      '일반 알림',
      channelDescription:
          '앱 내 전반적인 알림을 설정합니다.\n중요도 변경 시 앱 내 설정이 제대로 작동하지 않을 수 있습니다.',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      data.type.notificationId,
      data.title,
      data.descrption,
      notificationDetails,
      payload: payload,
    );
  }
}

@pragma('vm:entry-point')
void onNotificationReceived(
  NotificationResponse notificationResponse,
) async {
  if (notificationResponse.payload == null) return;
  routeHandler(notificationResponse.payload!);
}