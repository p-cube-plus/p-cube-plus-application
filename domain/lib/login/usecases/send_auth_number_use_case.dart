import 'package:domain/login/repository/login_repository.dart';
import 'package:domain/login/value_objects/login_request_info_data.dart';
import 'package:get_it/get_it.dart';

class SendAuthNumberUseCase {
  final LoginRepository _loginService = GetIt.I.get<LoginRepository>();

  Future<LoginRequestInfoData> call(String phoneNumber) async {
    return await _loginService.sendAuthNumber(phoneNumber);
  }
}
