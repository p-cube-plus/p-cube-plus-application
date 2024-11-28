import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'push_notification_data.dart';

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
      onDidReceiveNotificationResponse: onForegroundNotificationReceived,
    );
  }

  void onForegroundNotificationReceived(
    NotificationResponse notificationResponse,
  ) async {
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
    // );
    //streamController.add(payload);
  }

  Future<void> showNotification(
    PushNotificationData data,
  ) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'NORMAL_CHANNEL',
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
      data.id,
      data.title,
      data.descrption,
      notificationDetails,
    );
  }
}
