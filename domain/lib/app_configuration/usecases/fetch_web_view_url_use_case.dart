import 'package:domain/app_configuration/repository/app_configuration_repository.dart';
import 'package:get_it/get_it.dart';

class FetchWebViewUrlUseCase {
  final appConfigurationRepository = GetIt.I.get<AppConfigurationRepository>();

  Future<String> call() async {
    return await appConfigurationRepository.getWebViewUrl();
  }
}
