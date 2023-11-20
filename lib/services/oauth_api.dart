import 'package:p_cube_plus_application/services/base/pcube_api.dart';

import '../models/oauth_token.dart';

class OAuthApi extends PCubeApi {
  OAuthApi() : super(endPoint: "/oauth/naver/login");

  @override
  Future<OAuthToken?> get(
      {Function(dynamic jsonDecodeData)? decodeFunction,
      Map<String, String>? headers,
      Map<String, String>? queryParams}) async {
    return await super.get(
      decodeFunction: (jsonDecodeData) => OAuthToken.fromJson(jsonDecodeData),
      headers: headers,
      queryParams: queryParams,
    );
  }
}
