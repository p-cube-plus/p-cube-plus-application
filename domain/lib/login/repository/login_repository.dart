import 'package:domain/login/models/login_confirm_info_data.dart';
import 'package:domain/login/models/login_request_info_data.dart';
import 'package:domain/login/models/login_user_info_data.dart';

import '../models/auth_token_data.dart';

abstract class LoginRepository {
  Future<void> initAppData();
  Future<LoginUserInfoData> saveUserInfo(
      String name, String? phoneNumber, String? messageToken);
  Future<LoginRequestInfoData> sendAuthNumber(String phoneNumber);
  Future<LoginConfirmInfoData> confirmAuthNumber(String code);

  void setToken(String accessToken, String refreshToken);
  Future<AuthTokenData> getRefreshedToken();
  Future<void> deleteToken();
  Future<String?> getAccessToken();
  Future<void> saveAccessToken(String value);
  Future<void> deleteAccessToken();
  Future<String?> getRefreshToken();
  Future<void> saveRefreshToken(String value);
  Future<void> deleteRefreshToken();
}
