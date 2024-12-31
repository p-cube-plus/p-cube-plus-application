import 'package:domain/login/repository/login_repository.dart';
import 'package:get_it/get_it.dart';

class TryLoginUseCase {
  final LoginRepository _loginRepository = GetIt.I.get<LoginRepository>();

  Future<bool> call(String userName, String phoneNumber) async {
    final token = await _loginRepository.getFcmToken();
    final result =
        await _loginRepository.authenticateUser(userName, phoneNumber, token!);
    if (result.isMember) {
      final accessToken = result.tokenData!.accessToken;
      final refreshToken = result.tokenData!.refreshToken;
      await _loginRepository.setToken(accessToken, refreshToken);
    }

    return result.isMember;
  }
}
