import 'package:data/local/shared_preference/shared_preference_local_datasource.dart';
import 'package:get_it/get_it.dart';

bool getMockDataSetting() {
  return GetIt.I.get<SharedPreferenceLocalDatasource>().isMocking;
}
