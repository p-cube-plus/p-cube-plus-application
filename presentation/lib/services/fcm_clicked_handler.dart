import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void fcmClickedHandler(RemoteMessage message) {
  navigatorKey.currentState!.pushNamed("/message", arguments: message);
}
