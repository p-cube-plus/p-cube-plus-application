import 'package:data/models/remote/login/login_confirm_info_dto.dart';
import 'package:data/models/remote/login/login_request_info_dto.dart';
import 'package:data/models/remote/login/login_user_info_dto.dart';

abstract class LoginService {
  Future<LoginUserInfoDTO> saveUserInfo(
      String name, String? phoneNumber, String? messageToken);
  Future<LoginRequestInfoDTO> requestLogin(String phoneNumber);
  Future<LoginConfirmInfoDTO> confirmLogin(String? cookie, String code);
}
