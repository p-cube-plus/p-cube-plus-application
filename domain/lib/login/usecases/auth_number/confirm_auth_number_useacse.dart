import 'package:domain/login/repository/login_repository.dart';
import 'package:domain/login/value_objects/login_confirm_info_data.dart';
import 'package:get_it/get_it.dart';

class ConfirmAuthNumberUseCase {
  final LoginRepository _loginService = GetIt.I.get<LoginRepository>();

  Future<LoginConfirmInfoData> call(String authNumber) {
    return _loginService.confirmAuthNumber(authNumber);
  }
}
