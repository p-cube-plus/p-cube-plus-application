import 'package:data/local/beacon/beacon_scanner.dart';
import 'package:data/local/shared_preference/shared_preference_local_datasource.dart';
import 'package:data/remote/firebase/firebase_datasource.dart';
import 'package:domain/app_configuration/repository/app_configuration_repository.dart';
import 'package:domain/app_configuration/value_objects/theme_type.dart';
import 'package:get_it/get_it.dart';

class AppConfigurationRepositoryImpl implements AppConfigurationRepository {
  final sharedPreferenceLocalDatasource =
      GetIt.I.get<SharedPreferenceLocalDatasource>();
  final firebaseDatasource = GetIt.I.get<FirebaseDatasource>();
  final beaconScanner = GetIt.I.get<BeaconScanner>();

  @override
  ThemeType getTheme() {
    return ThemeType.values[sharedPreferenceLocalDatasource.themeIndex];
  }

  @override
  Future<void> initialize() async {
    Future.wait([
      firebaseDatasource.initialize(),
      sharedPreferenceLocalDatasource.initialize(),
      beaconScanner.initialize(),
    ]);
  }

  @override
  void setTheme(ThemeType themeType) {
    sharedPreferenceLocalDatasource.themeIndex = themeType.index;
  }
}
