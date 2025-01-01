import 'package:domain/login/repository/login_repository.dart';
import 'package:get_it/get_it.dart';

class ConfirmAuthNumberUseCase {
  final LoginRepository _loginService = GetIt.I.get<LoginRepository>();

  Future<bool> call(String authNumber) async {
    final result = await _loginService.confirmAuthNumber(authNumber);
    return result.isVerified;
  }
}
