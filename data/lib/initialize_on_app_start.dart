import 'package:data/local/shared_preference/shared_preference_local_datasource.dart';
import 'package:get_it/get_it.dart';

Future initializeOnAppStart() async {
  await Future.wait([
    GetIt.I.get<SharedPreferenceLocalDatasource>().initialize(),
  ]);
}
