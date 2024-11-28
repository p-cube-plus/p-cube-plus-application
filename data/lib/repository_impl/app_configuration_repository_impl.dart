import 'package:data/local/shared_preference/shared_preference_local_datasource.dart';
import 'package:data/firebase/firebase_manager.dart';
import 'package:domain/app_configuration/repository/app_configuration_repository.dart';
import 'package:domain/app_configuration/value_objects/theme_type.dart';
import 'package:get_it/get_it.dart';

class AppConfigurationRepositoryImpl implements AppConfigurationRepository {
  final sharedPreferenceLocalDatasource =
      GetIt.I.get<SharedPreferenceLocalDatasource>();
  final firebaseDatasource = GetIt.I.get<FirebaseManager>();

  @override
  ThemeType getTheme() {
    return ThemeType.values[sharedPreferenceLocalDatasource.themeIndex];
  }

  @override
  void setTheme(ThemeType themeType) {
    sharedPreferenceLocalDatasource.themeIndex = themeType.index;
  }
}
