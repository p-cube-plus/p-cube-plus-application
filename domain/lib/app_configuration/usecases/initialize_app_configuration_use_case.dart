import 'package:domain/app_configuration/repository/app_configuration_repository.dart';
import 'package:get_it/get_it.dart';

class InitializeAppConfigurationUseCase {
  final appConfigurationRepository = GetIt.I.get<AppConfigurationRepository>();

  Future<void> call() {
    return appConfigurationRepository.initialize();
  }
}
