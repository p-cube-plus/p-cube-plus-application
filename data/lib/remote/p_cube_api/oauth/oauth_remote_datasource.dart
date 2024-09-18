import 'package:data/remote/common/header_builder.dart';
import 'package:data/remote/p_cube_api/p_cube_api.dart';
import 'package:data/remote/p_cube_api/oauth/response/confirm_auth_code_response_dto.dart';
import 'package:data/remote/p_cube_api/oauth/response/validate_user_response_dto.dart';
import 'package:data/utils/json_util.dart';

import 'body/confirm_auth_code_body_dto.dart';
import 'body/send_auth_code_to_sms_body_dto.dart';
import 'body/validate_user_body_dto.dart';
import 'response/send_auth_code_to_sms_response_dto.dart';

/// 로그인을 위한 API로, Header Intercept에 제외된다.
/// 따라서 Header를 직접 전부 넣어줘야 한다.
class OauthRemoteDatasource {
  String? cookie;

  Future<SendAuthCodeToSmsResponseDTO> sendAuthCodeToSms(
    SendAuthCodeToSmsBodyDTO body,
  ) async {
    var response = await PCubeApi().post(
      "/oauth/code/request",
      headers: HeaderBuilder().contentTypeJson().build(),
      body: JsonUtil().mapToJson(body.toMap()),
    );

    cookie = response.headers["set-cookie"] ?? "";

    return JsonUtil().convertTo<SendAuthCodeToSmsResponseDTO>(
        SendAuthCodeToSmsResponseDTO.fromJson, response.body);
  }

  Future<ConfirmAuthCodeResponseDTO> confirmAuthCode(
    ConfirmAuthCodeBodyDTO body,
  ) async {
    var response = await PCubeApi().post(
      "/oauth/code/confirm",
      headers: HeaderBuilder().contentTypeJson().withCookie(cookie).build(),
      body: JsonUtil().mapToJson(body.toMap()),
    );

    return JsonUtil().convertTo<ConfirmAuthCodeResponseDTO>(
        ConfirmAuthCodeResponseDTO.fromJson, response.body);
  }

  Future<ValidateUserResponseDTO> validateUser(
    ValidateUserBodyDTO body,
  ) async {
    var response = await PCubeApi().post(
      "/oauth/user",
      headers: HeaderBuilder().contentTypeJson().build(),
      body: JsonUtil().mapToJson(body.toMap()),
    );

    return JsonUtil().convertTo<ValidateUserResponseDTO>(
        ValidateUserResponseDTO.fromJson, response.body);
  }
}
