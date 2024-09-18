import 'package:domain/login/models/auth_token_data.dart';
import 'package:domain/login/models/login_confirm_info_data.dart';
import 'package:domain/login/models/login_request_info_data.dart';
import 'package:domain/login/models/login_user_info_data.dart';
import 'package:domain/login/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<LoginConfirmInfoData> confirmAuthNumber(String code) {
    // TODO: implement confirmAuthNumber
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccessToken() {
    // TODO: implement deleteAccessToken
    throw UnimplementedError();
  }

  @override
  Future<void> deleteRefreshToken() {
    // TODO: implement deleteRefreshToken
    throw UnimplementedError();
  }

  @override
  Future<void> deleteToken() {
    // TODO: implement deleteToken
    throw UnimplementedError();
  }

  @override
  Future<String?> getAccessToken() {
    // TODO: implement getAccessToken
    throw UnimplementedError();
  }

  @override
  Future<String?> getRefreshToken() {
    // TODO: implement getRefreshToken
    throw UnimplementedError();
  }

  @override
  Future<AuthTokenData> getRefreshedToken() {
    // TODO: implement getRefreshedToken
    throw UnimplementedError();
  }

  @override
  Future<void> saveAccessToken(String value) {
    // TODO: implement saveAccessToken
    throw UnimplementedError();
  }

  @override
  Future<void> saveRefreshToken(String value) {
    // TODO: implement saveRefreshToken
    throw UnimplementedError();
  }

  @override
  Future<LoginUserInfoData> saveUserInfo(
      String name, String? phoneNumber, String? messageToken) {
    // TODO: implement saveUserInfo
    throw UnimplementedError();
  }

  @override
  Future<LoginRequestInfoData> sendAuthNumber(String phoneNumber) {
    // TODO: implement sendAuthNumber
    throw UnimplementedError();
  }

  @override
  void setToken(String accessToken, String refreshToken) {
    // TODO: implement setToken
  }
}
