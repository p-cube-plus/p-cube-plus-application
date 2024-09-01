import 'package:domain/services/attendance_service.dart';
import 'package:domain/services/firebase_service.dart';
import 'package:domain/services/home_service.dart';
import 'package:domain/services/login_service.dart';
import 'package:domain/services/notification_service.dart';
import 'package:domain/services/project_service.dart';
import 'package:domain/services/secure_storage_service.dart';
import 'package:domain/services/shared_preference_service.dart';
import 'package:domain/services/token_service.dart';
import 'package:domain/services/user_service.dart';
import 'package:get_it/get_it.dart';
import 'package:data/external/services/firebase_service.dart';
import 'package:data/local/secure_storage/secure_storage_service_impl.dart';
import 'package:data/local/shared_preference/shared_preference_service_impl.dart';
import 'package:data/mock/mock_login_service_impl.dart';
import 'package:data/remote/services/attendance_service_impl.dart';
import 'package:data/remote/services/home_service_impl.dart';
import 'package:data/remote/services/notification_service_impl.dart';
import 'package:data/remote/services/project_service_impl.dart';
import 'package:data/remote/services/token_service_impl.dart';
import 'package:data/remote/services/user_service_impl.dart';

void initService() {
  GetIt.I.registerLazySingleton<SharedPreferenceService>(
    () => SharedPreferenceServiceImpl(),
  );
  GetIt.I.registerLazySingleton<SecureStorageService>(
    () => SecureStorageServiceImpl(),
  );
  GetIt.I.registerFactory<AttendanceService>(
    () => AttendanceServiceImpl(),
  );
  GetIt.I.registerFactory<HomeService>(
    () => HomeServiceImpl(),
  );
  GetIt.I.registerFactory<LoginService>(
    () => MockLoginServiceImpl(),
  );
  GetIt.I.registerFactory<NotificationService>(
    () => NotificationServiceImpl(),
  );
  GetIt.I.registerFactory<ProjectService>(
    () => ProjectServiceImpl(),
  );
  GetIt.I.registerFactory<TokenService>(
    () => TokenServiceImpl(),
  );
  GetIt.I.registerFactory<UserService>(
    () => UserServiceImpl(),
  );
  GetIt.I.registerFactory<FirebaseService>(
    () => FirebaseServiceImpl(),
  );
}
