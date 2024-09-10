import 'package:data/remote/http/header_builder.dart';
import 'package:data/remote/http/pcube_api.dart';
import 'package:data/remote/p_cube_plus_api/auth/response/auth_token_response_dto.dart';
import 'package:data/utils/json_util.dart';

class AuthRemoteDatasource {
  Future<AuthTokenResponseDTO> getRefreshedToken() async {
    var response = await PCubeApi("/auth/token/refresh").get(
      headers: HeaderBuilder().contentTypeJson().withRefreshToken().build(),
    );

    return JsonUtil().convertTo<AuthTokenResponseDTO>(
        AuthTokenResponseDTO.fromJson, response.body);
  }

  Future<void> deleteToken() async {
    await PCubeApi("/auth/logout").delete();
  }
}
