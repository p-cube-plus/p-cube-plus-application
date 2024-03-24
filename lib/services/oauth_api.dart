import 'package:p_cube_plus_application/models/login/confirm_info.dart';
import 'package:p_cube_plus_application/models/login/request_info.dart';
import 'package:p_cube_plus_application/models/login/user_info.dart';
import 'package:p_cube_plus_application/services/base/pcube_api.dart';
import 'package:p_cube_plus_application/utilities/json_util.dart';

class OAuthUserApi {
  Future<UserInfo> post(
      String name, String? phoneNumber, String? messageToken) async {
    var response = await PCubeApi("/oauth/user").post(body: {
      "name": name,
      "phone_number": phoneNumber ?? "",
      "fcm_token": messageToken ?? "",
    });

    return JsonUtil.instance
        .convertTo<UserInfo>(UserInfo.fromJson, response.body);
  }
}

class OAuthRequestApi {
  Future<RequestInfo> post(String phoneNumber) async {
    var response = await PCubeApi("/oauth/code/request")
        .post(body: {"phone_number": phoneNumber});

    return JsonUtil.instance
        .convertToWithHeader<RequestInfo>(RequestInfo.fromJson, response);
  }
}

class OAuthConfirmApi {
  Future<ConfirmInfo> post(String? cookie, String code) async {
    var response = await PCubeApi("/oauth/code/confirm")
        .post(additionalHeader: {"cookie": cookie ?? ""}, body: {"code": code});

    return JsonUtil.instance
        .convertTo<ConfirmInfo>(ConfirmInfo.fromJson, response.body);
  }
}
