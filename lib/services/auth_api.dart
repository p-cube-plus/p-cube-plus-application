import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p_cube_plus_application/models/message.dart';
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
}

class AuthLogoutApi extends PCubeApi {
  AuthLogoutApi() : super(endPoint: "/auth/logout", isExternalApi: false);

  @override
  Future<Message?> delete({
    Function(http.Response response)? decodeFsuccessReturnFunctionnction,
    Map<String, String>? additionalHeader,
    Object? body,
    Encoding? encoding,
  }) async {
    return await super.delete(
      decodeFsuccessReturnFunctionnction: (response) =>
          Message.fromJson(jsonDecode(response.body)),
      additionalHeader: additionalHeader,
      body: body,
      encoding: encoding,
    );
  }
}
