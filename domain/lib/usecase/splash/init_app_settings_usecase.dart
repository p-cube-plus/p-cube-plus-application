import 'package:domain/services/firebase_service.dart';
import 'package:domain/services/shared_preference_service.dart';
import 'package:get_it/get_it.dart';

class InitAppSettingsUseCase {
  final FirebaseService _firebaseService = GetIt.I.get<FirebaseService>();
  final SharedPreferenceService _sharedPreferenceService =
      GetIt.I.get<SharedPreferenceService>();

  Future<void> call() async {
    await Future.wait([
      _firebaseService.init(),
      _sharedPreferenceService.initialize(),
    ]);
  }
}
