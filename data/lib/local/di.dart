import 'package:data/local/beacon/beacon_scanner.dart';
import 'package:data/local/local_db/attendance/attendance_local_datasource.dart';
import 'package:data/local/local_db/local_db.dart';
import 'package:data/local/secure_storage/secure_storage_local_datasource.dart';
import 'package:data/local/shared_preference/shared_preference_local_datasource.dart';
import 'package:get_it/get_it.dart';

void registLocalDatasource() {
  GetIt.I.registerLazySingleton<LocalDb>(
    () => LocalDb(),
  );
  GetIt.I.registerLazySingleton<AttendanceLocalDatasource>(
    () => AttendanceLocalDatasource(),
  );
  GetIt.I.registerLazySingleton<SecureStorageLocalDatasource>(
    () => SecureStorageLocalDatasource(),
  );
  GetIt.I.registerLazySingleton<SharedPreferenceLocalDatasource>(
    () => SharedPreferenceLocalDatasource(),
  );
  GetIt.I.registerLazySingleton<BeaconScanner>(
    () => BeaconScanner(),
  );
}
