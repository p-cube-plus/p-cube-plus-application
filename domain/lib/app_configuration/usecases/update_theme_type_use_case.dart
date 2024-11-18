import 'package:domain/app_configuration/repository/app_configuration_repository.dart';
import 'package:domain/app_configuration/value_objects/theme_type.dart';
import 'package:get_it/get_it.dart';

class UpdateThemeTypeUseCase {
  final appConfigurationRepository = GetIt.I.get<AppConfigurationRepository>();

  void call(ThemeType type) {
    appConfigurationRepository.setTheme(type);
  }
}
