import 'package:domain/login/repository/login_repository.dart';
import 'package:get_it/get_it.dart';

class FetchFcmTokenUseCase {
  final _lLoginRepository = GetIt.I.get<LoginRepository>();

  Future<String?> call() {
    return _lLoginRepository.getFcmToken();
  }
}
