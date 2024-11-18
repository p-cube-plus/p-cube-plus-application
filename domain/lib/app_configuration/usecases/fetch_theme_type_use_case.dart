import 'package:domain/app_configuration/repository/app_configuration_repository.dart';
import 'package:domain/app_configuration/value_objects/theme_type.dart';
import 'package:get_it/get_it.dart';

class FetchThemeTypeUseCase {
  final appConfigurationRepository = GetIt.I.get<AppConfigurationRepository>();

  ThemeType call() {
    return appConfigurationRepository.getTheme();
  }
}
