import 'package:data/remote/common/header_builder.dart';
import 'package:data/remote/p_cube_api/auth/response/auth_token_response_dto.dart';
import 'package:data/remote/p_cube_api/p_cube_api.dart';
import 'package:data/utils/json_util.dart';

class AuthRemoteDatasource {
  Future<void> deleteToken() async {
    await PCubeApi().delete("/auth/logout");
  }

  Future<AuthTokenResponseDTO> refreshToken(
    String refreshToken,
  ) async {
    var response = await PCubeApi().get(
      "/oauth/code/request",
      headers:
          HeaderBuilder().contentTypeJson().withToken(refreshToken).build(),
    );

    return JsonUtil().convertTo<AuthTokenResponseDTO>(
        AuthTokenResponseDTO.fromJson, response.body);
  }
}
