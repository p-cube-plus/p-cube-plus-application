import 'package:data/source/remote/firebase_initialize_service.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseInitializeServiceImpl implements FirebaseInitializeService {
  @override
  Future<void> initialize() async {
    Firebase.initializeApp();
  }
}
