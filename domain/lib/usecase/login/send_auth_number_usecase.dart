import 'package:domain/models/login/login_request_info_data.dart';
import 'package:domain/services/login_service.dart';
import 'package:get_it/get_it.dart';

class SendAuthNumberUseCase {
  final LoginService _loginService = GetIt.I.get<LoginService>();

  Future<LoginRequestInfoData> call(String phoneNumber) {
    return _loginService.sendAuthNumber(phoneNumber);
  }
}
