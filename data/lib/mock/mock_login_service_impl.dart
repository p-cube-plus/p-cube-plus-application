import 'package:domain/models/login/login_confirm_info_data.dart';
import 'package:domain/models/login/login_request_info_data.dart';
import 'package:domain/models/login/login_user_info_data.dart';
import 'package:domain/services/login_service.dart';

class MockLoginServiceImpl implements LoginService {
  @override
  Future<LoginConfirmInfoData> confirmAuthNumber(String code) async {
    await Future.delayed(const Duration(seconds: 3));
    return LoginConfirmInfoData(isVerified: true);
  }

  @override
  Future<LoginRequestInfoData> sendAuthNumber(String phoneNumber) async {
    await Future.delayed(const Duration(seconds: 3));
    return LoginRequestInfoData(isValid: true, authNumber: "123456");
  }

  @override
  Future<LoginUserInfoData> saveUserInfo(
      String name, String? phoneNumber, String? messageToken) async {
    await Future.delayed(const Duration(seconds: 3));
    return LoginUserInfoData(
      isMember: false,
      accessToken: null,
      refreshToken: null,
      message: "",
    );
  }
}
