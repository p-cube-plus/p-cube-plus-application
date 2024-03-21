import 'package:p_cube_plus_application/models/message.dart';
import 'package:p_cube_plus_application/services/base/pcube_api.dart';
import 'package:p_cube_plus_application/utilities/api_util.dart';
import 'package:p_cube_plus_application/utilities/token_manager.dart';

import '../models/auth_token.dart';

class AuthTokenRefreshApi {
  Future<AuthToken?> get(String? refreshToken) async {
    if (refreshToken == null) {
      refreshToken = await TokenManager().getRefreshToken();
      if (refreshToken == null) return null;
    }

    var response = await PCubeApi("/auth/token/refresh").getExceptToken(
        additionalHeader: {'Authorization': 'Bearer $refreshToken'});

    return ApiUtil.instance.convertTo<AuthToken?>(AuthToken.fromJson, response);
  }
}

class AuthLogoutApi {
  Future<Message?> delete() async {
    var response = await PCubeApi("/auth/logout").delete();
    return ApiUtil.instance.convertTo<Message>(Message.fromJson, response);
  }
}
