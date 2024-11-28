import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:presentation/services/fcm_handler.dart'
    show fcmBackgroundHandler;
import 'package:presentation/services/fcm_handler.dart'
    show fcmForegroundHandler;
import 'package:presentation/services/fcm_clicked_handler.dart'
    show fcmClickedHandler;

/// aos: google-services.json
/// ios: GoogleService-Info.plist
Future<void> initializeFirebaseService() async {
  await Firebase.initializeApp();
  _setCrashlytics();
  _setFcmForeground();
  _setFcmBackground();
  _onNotificationClicked();
}

void _setCrashlytics() {
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
}

void _setFcmForeground() {
  FirebaseMessaging.onMessage.listen(fcmForegroundHandler);
}

/// handler 함수는 최상위 함수이며 익명일 수 없다.
void _setFcmBackground() {
  FirebaseMessaging.onBackgroundMessage(fcmBackgroundHandler);
}

Future<void> _onNotificationClicked() async {
  final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    /// ios: 종료 -> FCM 알림 클릭 -> 앱 실행 (Notification 페이로드 필요)
    /// aos: 포그라운드 -> FCM 알림 클릭 -> 앱 실행
    fcmClickedHandler(initialMessage);
  }

  // 백그라운드 -> FCM 알림 클릭 -> 앱 실행
  FirebaseMessaging.onMessageOpenedApp.listen((clickedMessage) {
    fcmClickedHandler(clickedMessage);
  });
}
