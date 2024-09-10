import 'package:domain/login/models/login_request_info_data.dart';
import 'package:domain/login/repository/login_repository.dart';
import 'package:get_it/get_it.dart';

class SendAuthNumberUseCase {
  final LoginRepository _loginService = GetIt.I.get<LoginRepository>();

  Future<LoginRequestInfoData> call(String phoneNumber) {
    return _loginService.sendAuthNumber(phoneNumber);
  }
}
