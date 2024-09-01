import 'package:domain/models/login/login_confirm_info_data.dart';
import 'package:domain/models/login/login_request_info_data.dart';
import 'package:domain/models/login/login_user_info_data.dart';
abstract class LoginService {
  Future<LoginUserInfoData> saveUserInfo(
      String name, String? phoneNumber, String? messageToken);
  Future<LoginRequestInfoData> sendAuthNumber(String phoneNumber);
  Future<LoginConfirmInfoData> confirmAuthNumber(String code);
}
