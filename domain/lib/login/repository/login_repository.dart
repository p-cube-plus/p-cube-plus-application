import 'package:domain/login/value_objects/login_confirm_info_data.dart';
import 'package:domain/login/value_objects/login_request_info_data.dart';
import 'package:domain/login/value_objects/login_user_info_data.dart';

abstract interface class LoginRepository {
  /// 전화번호 입력 후 인증번호 발송
  Future<LoginRequestInfoData> sendAuthNumber(String phoneNumber);

  /// 인증번호 입력 후 확인
  Future<LoginConfirmInfoData> confirmAuthNumber(String code);

  /// 이름 입력 후 유저 인증 및 토큰 발행
  Future<LoginUserInfoData> authenticateUser(
      String name, String phoneNumber, String messageToken);

  /// 로그인을 위한 FCM 토큰
  Future<String?> getFcmToken();

  Future<void> setToken(String accessToken, String refreshToken);
  Future<String?> getToken();
  Future<String?> getRefreshToken();

  Future<void> logout();
  Future<void> deleteUser();
}
