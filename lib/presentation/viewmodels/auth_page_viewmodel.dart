import 'package:flutter/material.dart';
import 'package:p_cube_plus_application/common/utils/phone_number_tool.dart';
import 'package:p_cube_plus_application/presentation/models/auth_model.dart';
import 'package:p_cube_plus_application/remote/services/oauth_service.dart';
import 'package:p_cube_plus_application/remote/utils/token_manager.dart';
import 'package:provider/provider.dart';

class AuthPageViewModel {
  final _authService = OAuthService();
  late AuthModel data;
  bool isPhoneNumber = true;
  bool isNeedToRetry = false;

  void initData(BuildContext context) {
    data = Provider.of<AuthModel>(context);
  }

  void savePhoneNumber() {
    data.phoneNumber = data.phoneNumber.trim();
    isPhoneNumber = PhoneNumberTool.isPhoneNumber(data.phoneNumber);
  }

  Future<bool> sendAuthNumberAndGetIsSuccess() async {
    isNeedToRetry = false;
    var response = await _authService.requestLogin(data.phoneNumber);
    data.authCode = response.cookie ?? "";
    isNeedToRetry = !response.isValid;
    return response.isValid;
  }

  Future<bool> isVerified() async {
    var response =
        await _authService.confirmLogin(data.authCode, data.phoneNumber);
    return response.isVerified;
  }

  Future<bool> tryLogin(String name) async {
    var messageToken = await FirebaseMessaging.instance.getToken();
    var response =
        await _authService.saveUserInfo(name, data.phoneNumber, messageToken);
    var isValid = response.isMember;
    if (isValid) {
      await TokenManager().saveToken(
        response.accessToken.toString(),
        response.refreshToken.toString(),
      );
    }

    return response.isMember;
  }
}
