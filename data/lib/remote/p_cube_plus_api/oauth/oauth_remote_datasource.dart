import 'package:data/remote/http/header_builder.dart';
import 'package:data/remote/http/pcube_api.dart';
import 'package:data/remote/p_cube_plus_api/oauth/response/confirm_auth_code_response_dto.dart';
import 'package:data/remote/p_cube_plus_api/oauth/response/validate_user_response_dto.dart';
import 'package:data/utils/json_util.dart';

import 'body/confirm_auth_code_body_dto.dart';
import 'body/send_auth_code_to_sms_body_dto.dart';
import 'body/validate_user_body_dto.dart';
import 'response/send_auth_code_to_sms_response_dto.dart';

class OauthRemoteDatasource {
  String? cookie;

  Future<SendAuthCodeToSmsResponseDTO> sendAuthCodeToSms(
    SendAuthCodeToSmsBodyDTO body,
  ) async {
    var response = await PCubeApi("/oauth/code/request").post(
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
    var response = await PCubeApi("/oauth/code/confirm").post(
      headers: HeaderBuilder().contentTypeJson().withCookie(cookie).build(),
      body: JsonUtil().mapToJson(body.toMap()),
    );

    return JsonUtil().convertTo<ConfirmAuthCodeResponseDTO>(
        ConfirmAuthCodeResponseDTO.fromJson, response.body);
  }

  Future<ValidateUserResponseDTO> validateUser(
    ValidateUserBodyDTO body,
  ) async {
    var response = await PCubeApi("/oauth/user").post(
      headers: HeaderBuilder().contentTypeJson().build(),
      body: JsonUtil().mapToJson(body.toMap()),
    );

    return JsonUtil().convertTo<ValidateUserResponseDTO>(
        ValidateUserResponseDTO.fromJson, response.body);
  }
}
