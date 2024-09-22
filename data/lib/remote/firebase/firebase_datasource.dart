import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseDatasource {
  Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  Future<String?> getFcmToken() {
    return FirebaseMessaging.instance.getToken();
  }
}
