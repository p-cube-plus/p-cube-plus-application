import 'package:data/local/local_db/attendance/attendance_local_datasource.dart';
import 'package:data/local/local_db/local_db.dart';
import 'package:data/local/secure_storage/secure_storage_local_datasource.dart';
import 'package:data/local/shared_preference/shared_preference_local_datasource.dart';
import 'package:get_it/get_it.dart';

Future<void> registLocalDatasource() async {
  GetIt.I.registerSingleton<LocalDb>(
    LocalDb(),
  );
  GetIt.I.registerLazySingleton<AttendanceLocalDatasource>(
    () => AttendanceLocalDatasource(),
  );
  GetIt.I.registerLazySingleton<SecureStorageLocalDatasource>(
    () => SecureStorageLocalDatasource(),
  );
  GetIt.I.registerSingleton<SharedPreferenceLocalDatasource>(
    SharedPreferenceLocalDatasource(),
  );

  await Future.wait([
    GetIt.I.get<LocalDb>().initialize(),
    GetIt.I.get<SharedPreferenceLocalDatasource>().initialize(),
  ]);
}
