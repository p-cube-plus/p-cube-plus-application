import 'package:data/models/remote/login/login_confirm_info_dto.dart';
import 'package:data/models/remote/login/login_request_info_dto.dart';
import 'package:data/models/remote/login/login_user_info_dto.dart';
import 'package:data/source/remote/login_service.dart';
import 'package:data/utils/json_util.dart';

import '../http/header_builder.dart';
import '../http/pcube_api.dart';

class LoginServiceImpl implements LoginService {
  @override
  Future<LoginUserInfoDTO> saveUserInfo(
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
        .convertTo<LoginUserInfoDTO>(LoginUserInfoDTO.fromJson, response.body);
  }

  @override
  Future<LoginRequestInfoDTO> requestLogin(String phoneNumber) async {
    var response = await PCubeApi("/oauth/code/request").post(
      headers: HeaderBuilder().contentTypeJson().build(),
      body: {"phone_number": phoneNumber},
    );

    var isValid =
        JsonUtil().convertTo<bool>((json) => json["is_success"], response.body);
    var cookie = response.headers["set-cookie"] ?? "";

    return LoginRequestInfoDTO(isValid: isValid, cookie: cookie);
  }

  @override
  Future<LoginConfirmInfoDTO> confirmLogin(String? cookie, String code) async {
    var response = await PCubeApi("/oauth/code/confirm").post(
      headers: HeaderBuilder().contentTypeJson().withCookie(cookie).build(),
      body: {"code": code},
    );

    return JsonUtil().convertTo<LoginConfirmInfoDTO>(
        LoginConfirmInfoDTO.fromJson, response.body);
  }
}
