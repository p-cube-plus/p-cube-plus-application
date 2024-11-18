import 'package:data/local/shared_preference/shared_preference_local_datasource.dart';
import 'package:get_it/get_it.dart';

Future initOnAppStart() async {
  await GetIt.I.get<SharedPreferenceLocalDatasource>().initialize();
}
