import 'package:data/local/secure_storage/secure_storage_local_datasource.dart';
import 'package:data/local/shared_preference/shared_preference_local_datasource.dart';
import 'package:get_it/get_it.dart';

void registLocalDatasource() {
  GetIt.I.registerLazySingleton<SecureStorageLocalDatasource>(
    () => SecureStorageLocalDatasource(),
  );
  GetIt.I.registerLazySingleton<SharedPreferenceLocalDatasource>(
    () => SharedPreferenceLocalDatasource(),
  );
}
