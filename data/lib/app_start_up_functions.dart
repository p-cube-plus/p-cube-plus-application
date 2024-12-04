import 'package:data/local/secure_storage/secure_storage_local_datasource.dart';
import 'package:data/local/shared_preference/shared_preference_local_datasource.dart';
import 'package:domain/common/extensions/future_extension.dart';
import 'package:get_it/get_it.dart';

bool getMockDataSetting() {
  return GetIt.I.get<SharedPreferenceLocalDatasource>().isMocking;
}

Future<bool> getLoggedIn() async {
  final isExistAccessToken = await GetIt.I
      .get<SecureStorageLocalDatasource>()
      .getAccessToken()
      .getOrNull();
  return isExistAccessToken != null;
}
