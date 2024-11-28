import 'package:data/firebase/firebase_manager.dart';
import 'package:domain/logging/repository/logging_repository.dart';
import 'package:get_it/get_it.dart';

class LoggingRepositoryImpl implements LoggingRepository {
  final firebaseDatasource = GetIt.I.get<FirebaseManager>();

  @override
  Future<void> logEvent(String eventName, Map<String, Object>? parameters) {
    return firebaseDatasource.sendFirebaseLog(eventName, parameters);
  }
}
