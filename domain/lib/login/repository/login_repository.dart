import 'package:domain/login/value_objects/login_confirm_info_data.dart';
import 'package:domain/login/value_objects/login_request_info_data.dart';
import 'package:domain/login/value_objects/login_user_info_data.dart';

abstract interface class LoginRepository {
  // 인증번호 발송
  Future<LoginRequestInfoData> sendAuthNumber(String phoneNumber);

  // 인증번호 확인
  Future<LoginConfirmInfoData> confirmAuthNumber(String code);

  // 사용자 인증 및 토큰 발행
  Future<LoginUserInfoData> authenticateUser(
      String name, String phoneNumber, String messageToken);

  void setToken(String accessToken, String refreshToken);
  Future<String?> getToken();
  Future<String?> getRefreshToken();

  Future<void> logout();
}
