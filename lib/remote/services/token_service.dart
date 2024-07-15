import 'package:p_cube_plus_application/remote/models/message_dto.dart';
import 'package:p_cube_plus_application/remote/http/header_builder.dart';
import 'package:p_cube_plus_application/remote/http/pcube_api.dart';
import 'package:p_cube_plus_application/remote/models/token_dto.dart';
import 'package:p_cube_plus_application/remote/utils/json_util.dart';

class TokenService {
  Future<AuthTokenDTO> getRefreshedToken() async {
    var response = await PCubeApi("/auth/token/refresh").get(
      headers:
          (await HeaderBuilder().contentTypeJson().withRefreshToken()).build(),
    );
    return JsonUtil()
        .convertTo<AuthTokenDTO>(AuthTokenDTO.fromJson, response.body);
  }

  Future<MessageDTO> deleteToken() async {
    var response = await PCubeApi("/auth/logout").delete();
    return JsonUtil().convertTo<MessageDTO>(MessageDTO.fromJson, response.body);
  }
}
