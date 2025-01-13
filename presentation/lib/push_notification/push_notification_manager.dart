import 'package:domain/common/extensions/future_extension.dart';
import 'package:domain/notification/usecases/fetch_can_send_notification_use_case.dart';
import 'package:domain/notification/usecases/fetch_is_notification_on_use_case.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:presentation/route_handler/route_type.dart';
import 'push_notification_data.dart';
import 'package:presentation/route_handler/route_handler.dart';

class PushNotificationManager {
  static final _instance = PushNotificationManager._internal();
  PushNotificationManager._internal();
  factory PushNotificationManager() => _instance;

  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final _notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'NORMAL_CHANNEL', // Android\app\res\values\notification_channel_string.xml
      '일반 알림',
      channelDescription:
          '앱 내 전반적인 알림을 설정합니다.\n중요도 변경 시 앱 내 설정이 제대로 작동하지 않을 수 있습니다.',
      importance: Importance.max,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
  );

  Future<void> initialize() async {
    final aosInit = AndroidInitializationSettings('mipmap/launcher_icon');
    final iosInit = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final initializationSettings = InitializationSettings(
      android: aosInit,
      iOS: iosInit,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationReceived,
      onDidReceiveBackgroundNotificationResponse: onNotificationReceived,
    );
  }

  Future<void> showBackgroundNotification(
    PushNotificationData data, {
    String? payload,
  }) async {
    await _flutterLocalNotificationsPlugin.show(
      data.type.notificationId,
      data.title,
      data.descrption,
      _notificationDetails,
      payload: payload,
    );
  }

  Future<void> showNotification(
    PushNotificationData data, {
    String? payload,
  }) async {
    final canSend =
        await FetchCanSendNotificationUseCase()().getOrDefault(true);
    if (!canSend) return;

    final isSettingOn =
        await FetchIsNotificationOnUseCase()(data.type.toNotificationType())
            .getOrDefault(true);
    if (!isSettingOn) return;

    await _flutterLocalNotificationsPlugin.show(
      data.type.notificationId,
      data.title,
      data.descrption,
      _notificationDetails,
      payload: payload,
    );
  }
}

@pragma('vm:entry-point')
void onNotificationReceived(
  NotificationResponse notificationResponse,
) async {
  if (notificationResponse.payload == null) return;

  try {
    final routeType = RouteType.values.byName(notificationResponse.payload!);
    routeHandler(routeType);
  } catch (e) {
    routeHandler(RouteType.home);
  }
}
