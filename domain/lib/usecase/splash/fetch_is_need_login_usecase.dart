import 'package:domain/services/secure_storage_service.dart';
import 'package:get_it/get_it.dart';

class FetchIsNeedLoginUseCase {
  final SecureStorageService _secureStorageService =
      GetIt.I.get<SecureStorageService>();

  Future<bool> call() async {
    final accessToken = await _secureStorageService.getAccessToken();
    return accessToken != null;
  }
}
