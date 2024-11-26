import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseDatasource {
  late final _analytics = FirebaseAnalytics.instance;

  Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  Future<String?> getFcmToken() {
    return FirebaseMessaging.instance.getToken();
  }

  Future<void> sendFirebaseLog(
    String eventName,
    Map<String, Object>? parameters,
  ) async {
    await _analytics.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }
}
