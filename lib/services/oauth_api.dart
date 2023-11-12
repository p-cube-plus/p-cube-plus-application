import 'dart:convert';
import 'package:p_cube_plus_application/services/base/pcube_api.dart';
import '../models/oauth_token.dart';

class OAuthApi extends PCubeApi {
  OAuthApi() : super(endPoint: "/oauth/naver/login", isExternalApi: true);

  Future<OAuthToken?> naver(String refreshToken, String identifier, String name,
      String phoneNumber) async {
    Map<String, String>? queryParams = {
      "refresh_token": refreshToken,
      "identifier": identifier,
      "name": name,
      "phone_number": phoneNumber,
    };

    return await get(
      queryParams: queryParams,
      successReturnFunction: (body) =>
          OAuthToken.fromJson(jsonDecode(body) as Map<String, dynamic>),
    );
  }
}
