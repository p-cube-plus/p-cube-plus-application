import 'package:domain/login/repository/login_repository.dart';
import 'package:get_it/get_it.dart';

class FetchIsNeedLoginUseCase {
  final _loginRepository = GetIt.I.get<LoginRepository>();

  Future<bool> call() async {
    final accessToken = await _loginRepository.getToken();
    return accessToken != null;
  }
}
