import 'package:data/mock/mock_attendance_repository_impl.dart';
import 'package:data/mock/mock_fee_repository_impl.dart';
import 'package:data/mock/mock_schedule_repository_impl.dart';
import 'package:data/mock/mock_user_repository_impl.dart';
import 'package:data/repository_impl/app_configuration_repository_impl.dart';
import 'package:data/repository_impl/attendance_repository_impl.dart';
import 'package:data/repository_impl/login_repository_impl.dart';
import 'package:data/repository_impl/member_repository_impl.dart';
import 'package:data/repository_impl/notification_repository_impl.dart';
import 'package:data/repository_impl/product_repository_impl.dart';
import 'package:data/repository_impl/project_repository_impl.dart';
import 'package:domain/app_configuration/repository/app_configuration_repository.dart';
import 'package:domain/attendance/repository/attendance_repository.dart';
import 'package:domain/fee/repository/fee_repository.dart';
import 'package:domain/login/repository/login_repository.dart';
import 'package:domain/member/repository/member_repository.dart';
import 'package:domain/notification/repository/notification_repository.dart';
import 'package:domain/product/repository/product_repository.dart';
import 'package:domain/project/repository/project_repository.dart';
import 'package:domain/schedule/repository/schedule_repository.dart';
import 'package:domain/user/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

void registRepository() {
  GetIt.I.registerLazySingleton<AppConfigurationRepository>(
    () => AppConfigurationRepositoryImpl(),
  );
  GetIt.I.registerLazySingleton<AttendanceRepository>(
    () => MockAttendanceRepositoryImpl(),
  );
  GetIt.I.registerLazySingleton<FeeRepository>(
    () => MockFeeRepositoryImpl(),
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
    () => MockScheduleRepositoryImpl(),
  );
  GetIt.I.registerLazySingleton<UserRepository>(
    () => MockUserRepositoryImpl(),
  );
}
