import 'package:domain/models/login/login_confirm_info_data.dart';
import 'package:domain/services/login_service.dart';
import 'package:get_it/get_it.dart';

class ConfirmAuthNumberUseCase {
  final LoginService _loginService = GetIt.I.get<LoginService>();

  Future<LoginConfirmInfoData> call(String authNumber) {
    return _loginService.confirmAuthNumber(authNumber);
  }
}
