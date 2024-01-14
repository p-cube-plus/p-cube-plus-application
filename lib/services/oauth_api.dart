import 'dart:convert';
import 'package:p_cube_plus_application/models/login/confirm_info.dart';
import 'package:p_cube_plus_application/models/login/request_info.dart';
import 'package:p_cube_plus_application/models/login/user_info.dart';
import 'package:p_cube_plus_application/services/base/pcube_api.dart';

class OAuthUserApi extends PCubeApi {
  OAuthUserApi() : super(endPoint: "/oauth/user", isExternalApi: true);

  @override
  Future<UserInfo> post({
    Function(dynamic body)? successReturnFunction,
    Map<String, String>? additionalHeader,
    Object? body,
    Encoding? encoding,
  }) async =>
      await super.post(
        successReturnFunction: (data) => UserInfo.fromJson(jsonDecode(data)),
        body: body,
        encoding: encoding,
      );
}

class OAuthRequestApi extends PCubeApi {
  OAuthRequestApi()
      : super(endPoint: "/oauth/code/request", isExternalApi: true);

  @override
  Future<RequestInfo> post({
    Function(dynamic body)? successReturnFunction,
    Map<String, String>? additionalHeader,
    Object? body,
    Encoding? encoding,
  }) async =>
      await super.post(
        successReturnFunction: (data) => RequestInfo.fromJson(jsonDecode(data)),
        body: body,
        encoding: encoding,
      );
}

class OAuthConfirmApi extends PCubeApi {
  OAuthConfirmApi()
      : super(endPoint: "/oauth/code/confirm", isExternalApi: true);

  @override
  Future<ConfirmInfo> post({
    Function(dynamic body)? successReturnFunction,
    Map<String, String>? additionalHeader,
    Object? body,
    Encoding? encoding,
  }) async =>
      await super.post(
        successReturnFunction: (data) => ConfirmInfo.fromJson(jsonDecode(data)),
        body: body,
        encoding: encoding,
      );
}
