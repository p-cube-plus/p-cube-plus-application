import 'package:data/remote/firebase/firebase_datasource.dart';
import 'package:data/remote/p_cube_api/accounting/accounting_remote_datasource.dart';
import 'package:data/remote/p_cube_api/attendance/attendance_remote_datasource.dart';
import 'package:data/remote/p_cube_api/auth/auth_remote_datasource.dart';
import 'package:data/remote/p_cube_api/home/home_remote_datasource.dart';
import 'package:data/remote/p_cube_api/notification/notification_remote_datasource.dart';
import 'package:data/remote/p_cube_api/oauth/oauth_remote_datasource.dart';
import 'package:data/remote/p_cube_api/product/product_remote_datasource.dart';
import 'package:data/remote/p_cube_api/project/project_remote_datasource.dart';
import 'package:data/remote/p_cube_api/rent/models/rent_remote_datasource.dart';
import 'package:data/remote/p_cube_api/seminar/seminar_remote_datasource.dart';
import 'package:data/remote/p_cube_api/user/user_remote_datasource.dart';
import 'package:data/remote/p_cube_api/warning/warning_remote_datasource.dart';
import 'package:get_it/get_it.dart';

void registRemoteDatasource() {
  GetIt.I.registerLazySingleton<FirebaseDatasource>(
    () => FirebaseDatasource(),
  );
  GetIt.I.registerLazySingleton<AccountingRemoteDatasource>(
    () => AccountingRemoteDatasource(),
  );
  GetIt.I.registerLazySingleton<AttendanceRemoteDatasource>(
    () => AttendanceRemoteDatasource(),
  );
  GetIt.I.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(),
  );
  GetIt.I.registerLazySingleton<HomeRemoteDatasource>(
    () => HomeRemoteDatasource(),
  );
  GetIt.I.registerLazySingleton<NotificationRemoteDatasource>(
    () => NotificationRemoteDatasource(),
  );
  GetIt.I.registerLazySingleton<OauthRemoteDatasource>(
    () => OauthRemoteDatasource(),
  );
  GetIt.I.registerLazySingleton<ProductRemoteDatasource>(
    () => ProductRemoteDatasource(),
  );
  GetIt.I.registerLazySingleton<ProjectRemoteDatasource>(
    () => ProjectRemoteDatasource(),
  );
  GetIt.I.registerLazySingleton<RentRemoteDatasource>(
    () => RentRemoteDatasource(),
  );
  GetIt.I.registerLazySingleton<SeminarRemoteDatasource>(
    () => SeminarRemoteDatasource(),
  );
  GetIt.I.registerLazySingleton<UserRemoteDatasource>(
    () => UserRemoteDatasource(),
  );
  GetIt.I.registerLazySingleton<WarningRemoteDatasource>(
    () => WarningRemoteDatasource(),
  );
}
