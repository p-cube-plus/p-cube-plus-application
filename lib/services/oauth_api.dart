import 'dart:convert';
import 'package:p_cube_plus_application/models/login/user_info.dart';
import 'package:p_cube_plus_application/services/base/pcube_api.dart';
import '../models/oauth_token.dart';

class OAuthUserApi extends PCubeApi {
  OAuthUserApi({required this.userInfo})
      : super(endPoint: "/oauth/user", isExternalApi: true);

  final UserInfo userInfo;

  @override
  Future<UserInfo> post({
    Function(dynamic body)? successReturnFunction,
    Map<String, String>? additionalHeader,
    Object? body,
    Encoding? encoding,
  }) async =>
      await super.post(
        successReturnFunction: successReturnFunction,
        additionalHeader: additionalHeader,
        body: body,
        encoding: encoding,
      );
}
