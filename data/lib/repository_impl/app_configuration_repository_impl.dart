import 'package:data/local/shared_preference/shared_preference_local_datasource.dart';
import 'package:data/remote/firebase/firebase_datasource.dart';
import 'package:domain/app_configuration/models/theme_type.dart';
import 'package:domain/app_configuration/repository/app_configuration_repository.dart';
import 'package:get_it/get_it.dart';

class AppConfigurationRepositoryImpl implements AppConfigurationRepository {
  final sharedPreferenceLocalDatasource =
      GetIt.I.get<SharedPreferenceLocalDatasource>();
  final firebaseDatasource = GetIt.I.get<FirebaseDatasource>();

  @override
  ThemeType getTheme() {
    return ThemeType.values[sharedPreferenceLocalDatasource.themeIndex];
  }

  @override
  Future<void> initialize() async {
    Future.wait([
      firebaseDatasource.initialize(),
      sharedPreferenceLocalDatasource.initialize(),
    ]);
  }

  @override
  void setTheme(ThemeType themeType) {
    sharedPreferenceLocalDatasource.themeIndex = themeType.index;
  }
}
