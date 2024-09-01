import 'package:domain/models/login/login_confirm_info_data.dart';
import 'package:domain/models/login/login_request_info_data.dart';
import 'package:domain/models/login/login_user_info_data.dart';
import 'package:domain/services/login_service.dart';

import '../../utils/json_util.dart';
import '../http/header_builder.dart';
import '../http/pcube_api.dart';
import '../models/login/login_confirm_info_dto.dart';
import '../models/login/login_request_info_dto.dart';
import '../models/login/login_user_info_dto.dart';

class LoginServiceImpl implements LoginService {
  @override
  Future<LoginUserInfoData> saveUserInfo(
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
        .convertTo<LoginUserInfoDTO>(LoginUserInfoDTO.fromJson, response.body)
        .toDomain();
  }

  @override
  Future<LoginRequestInfoData> sendAuthNumber(String phoneNumber) async {
    var response = await PCubeApi("/oauth/code/request").post(
      headers: HeaderBuilder().contentTypeJson().build(),
      body: {"phone_number": phoneNumber},
    );

    var isValid =
        JsonUtil().convertTo<bool>((json) => json["is_success"], response.body);
    var cookie = response.headers["set-cookie"] ?? "";

    return LoginRequestInfoDTO(isValid: isValid, cookie: cookie).toDomain();
  }

  @override
  Future<LoginConfirmInfoData> confirmAuthNumber(String code) async {
    var response = await PCubeApi("/oauth/code/confirm").post(
      //headers: HeaderBuilder().contentTypeJson().withCookie(cookie).build(),
      body: {"code": code},
    );

    return JsonUtil()
        .convertTo<LoginConfirmInfoDTO>(
            LoginConfirmInfoDTO.fromJson, response.body)
        .toDomain();
  }
}
