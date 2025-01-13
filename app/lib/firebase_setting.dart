import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:presentation/push_notification/push_notification_data.dart';
import 'package:presentation/route_handler/route_handler.dart';
import 'package:presentation/route_handler/route_type.dart';
import 'package:presentation/push_notification/push_notification_manager.dart';

/// aos: google-services.json
/// ios: GoogleService-Info.plist
Future<void> initializeFirebaseService() async {
  await Firebase.initializeApp();
  _setCrashlytics();
  _setFcmForeground();
  _setFcmBackground();
  await _onNotificationClicked();
}

void _setCrashlytics() {
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
}

void _setFcmForeground() {
  FirebaseMessaging.onMessage.listen(fcmforegroundHandler);
}

void _setFcmBackground() {
  FirebaseMessaging.onBackgroundMessage(fcmBackgroundHandler);
}

Future<void> fcmforegroundHandler(RemoteMessage message) async {
  PushNotificationManager().showNotification(
    PushNotificationData.fcm(
      message.data["type"],
      title: message.data["title"],
      descrption: message.data["body"],
    ),
    payload: message.data["routeType"],
  );
}

/// handler 함수는 최상위 함수이며 익명일 수 없다.
@pragma('vm:entry-point')
Future<void> fcmBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) return;
}

Future<void> _onNotificationClicked() async {
  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    /// ios: 종료 -> FCM 알림 클릭 -> 앱 실행 (Notification 페이로드 필요)
    /// aos: 포그라운드 -> FCM 알림 클릭 -> 앱 실행
    onClickFcm(initialMessage.data["routeType"]);
  }

  // 백그라운드 -> FCM 알림 클릭 -> 앱 실행
  FirebaseMessaging.onMessageOpenedApp.listen((clickedMessage) {
    onClickFcm(clickedMessage.data["routeType"]);
  });
}

void onClickFcm(String routeTypeString) {
  try {
    final routeType = RouteType.values.byName(routeTypeString);
    routeHandler(routeType);
  } catch (e) {
    routeHandler(RouteType.home);
  }
}
