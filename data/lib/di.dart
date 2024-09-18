import 'package:data/repository_impl/app_configuration_repository_impl.dart';
import 'package:data/repository_impl/attendance_repository_impl.dart';
import 'package:data/repository_impl/fee_repository_impl.dart';
import 'package:data/repository_impl/login_repository_impl.dart';
import 'package:data/repository_impl/member_repository_impl.dart';
import 'package:data/repository_impl/notification_repository_impl.dart';
import 'package:data/repository_impl/product_repository_impl.dart';
import 'package:data/repository_impl/project_repository_impl.dart';
import 'package:data/repository_impl/schedule_repository_impl.dart';
import 'package:data/repository_impl/user_repository_impl.dart';
import 'package:domain/app_configuration/repository/app_configuration_repository.dart';
import 'package:domain/attendance/repository/attendance_repository.dart';
import 'package:domain/login/repository/login_repository.dart';
import 'package:get_it/get_it.dart';

void registRepository() {
  GetIt.I.registerLazySingleton<AppConfigurationRepository>(
    () => AppConfigurationRepositoryImpl(),
  );
  GetIt.I.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(),
  );
  GetIt.I.registerLazySingleton<FeeRepository>(
    () => FeeRepositoryImpl(),
  );
  GetIt.I.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(),
  );
  GetIt.I.registerLazySingleton<MemberRepository>(
    () => MemberRepositoryImpl(),
  );
  GetIt.I.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(),
  );
  GetIt.I.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(),
  );
  GetIt.I.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoryImpl(),
  );
  GetIt.I.registerLazySingleton<ScheduleRepository>(
    () => ScheduleRepositoryImpl(),
  );
  GetIt.I.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(),
  );
}
