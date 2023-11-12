import 'dart:convert';
import 'package:p_cube_plus_application/utilities/token_manager.dart';

import '../../models/oauth_token.dart';
import '../base/pcube_api.dart';

class AuthApi extends PCubeApi {
  AuthApi() : super(endPoint: "/auth/token/");

  Future<void> refresh() async {
    String refreshToken = TokenManager().getRefreshToken().toString();
    Map<String, String>? headers = {"Content-Type": "application/json"};
    Map<String, String>? body = {"refresh_token": refreshToken};

    var response = await post(additionalHeader: headers, body: body);

    switch (response.statusCode) {
      case 200:
        Map<String, String> json = jsonDecode(response.body);
        OAuthToken token = OAuthToken.fromJson(json);
        TokenManager().setAccessToken(token.accessToken.toString());
        TokenManager().setRefreshToken(token.refreshToken.toString());
        break;
      case 400:
        Map<String, String> json = jsonDecode(response.body);
        OAuthToken token = OAuthToken.fromJson(json);
        // Dialog 등 show
        // token.message.toString();
        break;
    }
  }
}
