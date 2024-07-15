import 'package:p_cube_plus_application/remote/models/confirm_info_dto.dart';
import 'package:p_cube_plus_application/remote/models/request_info_dto.dart';
import 'package:p_cube_plus_application/remote/models/user_info_dto.dart';
import 'package:p_cube_plus_application/remote/http/header_builder.dart';
import 'package:p_cube_plus_application/remote/http/pcube_api.dart';
import 'package:p_cube_plus_application/remote/utils/json_util.dart';

class OAuthService {
  Future<UserInfoDTO> saveUserInfo(
      String name, String? phoneNumber, String? messageToken) async {
    var response = await PCubeApi("/oauth/user").post(
      headers: HeaderBuilder().contentTypeJson().build(),
      body: {
        "name": name,
        "phone_number": phoneNumber ?? "",
        "fcm_token": messageToken ?? "",
      },
    );

    return JsonUtil()
        .convertTo<UserInfoDTO>(UserInfoDTO.fromJson, response.body);
  }

  Future<RequestInfoDTO> requestLogin(String phoneNumber) async {
    var response = await PCubeApi("/oauth/code/request").post(
      headers: HeaderBuilder().contentTypeJson().build(),
      body: {"phone_number": phoneNumber},
    );

    var isValid =
        JsonUtil().convertTo<bool>((json) => json["is_success"], response.body);
    var cookie = response.headers["set-cookie"] ?? "";

    return RequestInfoDTO(isValid: isValid, cookie: cookie);
  }

  Future<ConfirmInfoDTO> confirmLogin(String? cookie, String code) async {
    var response = await PCubeApi("/oauth/code/confirm").post(
      headers: HeaderBuilder().contentTypeJson().withCookie(cookie).build(),
      body: {"code": code},
    );

    return JsonUtil()
        .convertTo<ConfirmInfoDTO>(ConfirmInfoDTO.fromJson, response.body);
  }
}
