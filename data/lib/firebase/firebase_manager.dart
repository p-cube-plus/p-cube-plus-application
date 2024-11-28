import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseManager {
  late final _analytics = FirebaseAnalytics.instance;

  Future<void> sendFirebaseLog(
    String eventName,
    Map<String, Object>? parameters,
  ) async {
    await _analytics.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }

  Future<String?> getFcmToken() {
    return FirebaseMessaging.instance.getToken();
  }
}
