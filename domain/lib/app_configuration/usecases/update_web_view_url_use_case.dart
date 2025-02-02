import 'package:domain/app_configuration/repository/app_configuration_repository.dart';
import 'package:get_it/get_it.dart';

class UpdateWebViewUrlUseCase {
    final appConfigurationRepository = GetIt.I.get<AppConfigurationRepository>();

  Future<void> call(String newUrl) async {
    return await appConfigurationRepository.setWebViewUrl(newUrl);
  }
}