import 'dart:convert';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:p_cube_plus_application/services/base/pcube_api.dart';
import '../models/oauth_token.dart';

class OAuthApi extends PCubeApi {
  OAuthApi({required this.loginResult})
      : super(endPoint: "/oauth/naver/login", isExternalApi: true);

  final NaverLoginResult loginResult;

  Future<OAuthToken?> naver() async {
    NaverAccessToken token = await FlutterNaverLogin.currentAccessToken;

    Map<String, String>? queryParams = {
      "refresh_token": token.refreshToken,
      "identifier": loginResult.account.id,
      "name": loginResult.account.name,
      "phone_number": loginResult.account.mobile,
    };

    return await get(
      queryParams: queryParams,
      successReturnFunction: (body) =>
          OAuthToken.fromJson(jsonDecode(body) as Map<String, dynamic>),
    );
  }
}
