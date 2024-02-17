import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p_cube_plus_application/services/base/pcube_api.dart';
import 'package:p_cube_plus_application/utilities/token_manager.dart';

import '../models/auth_token.dart';

class AuthTokenRefreshApi extends PCubeApi {
  AuthTokenRefreshApi()
      : super(endPoint: "/auth/token/refresh", isExternalApi: false);

  @override
  Future<AuthToken?> get({
    Function(http.Response response)? successReturnFunction,
    Map<String, String>? additionalHeader,
    Map<String, String>? queryParams,
  }) async {
    String? refreshToken = await TokenManager().getRefreshToken();
    if (refreshToken == null) return null;
    if (additionalHeader == null)
      additionalHeader = {"Authorization": "Bearer $refreshToken"};
    else
      additionalHeader["Authorization"] = "Bearer $refreshToken";
    return await super.get(
      successReturnFunction: (response) => AuthToken.fromJson(
        jsonDecode(response.body),
      ),
      additionalHeader: additionalHeader,
      queryParams: queryParams,
    );
  }

  /*Future<bool> refresh() async {
    String refreshToken = TokenManager().getRefreshToken().toString();
    Map<String, String>? headers = {"Content-Type": "application/json"};
    Map<String, String>? body = {"refresh_token": refreshToken};

    var response = await post(additionalHeader: headers, body: body);

    return response != null;
  }*/
}
