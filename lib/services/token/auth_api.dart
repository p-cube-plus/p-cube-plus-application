import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p_cube_plus_application/services/base/pcube_api.dart';
import 'package:p_cube_plus_application/utilities/token_manager.dart';

import '../../models/oauth_token.dart';

class AuthApi extends PCubeApi {
  AuthApi() : super(endPoint: "/auth/token/");

  @override
  Future<OAuthToken?> post(
      {Function(http.Response response)? successReturnFunction,
      Map<String, String>? additionalHeader,
      Object? body,
      Encoding? encoding}) async {
    return await super.post(
      successReturnFunction: (response) => OAuthToken.fromJson(
        jsonDecode(response.body),
      ),
      additionalHeader: additionalHeader,
      body: body,
      encoding: encoding,
    );
  }

  Future<bool> refresh() async {
    String refreshToken = TokenManager().getRefreshToken().toString();
    Map<String, String>? headers = {"Content-Type": "application/json"};
    Map<String, String>? body = {"refresh_token": refreshToken};

    var response = await post(additionalHeader: headers, body: body);

    return response != null;
  }
}
