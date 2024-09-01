import 'package:domain/services/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseServiceImpl implements FirebaseService {
  @override
  Future<String?> getToken() {
    return FirebaseMessaging.instance.getToken();
  }

  @override
  Future<void> init() async {
    await Firebase.initializeApp();
  }
}
