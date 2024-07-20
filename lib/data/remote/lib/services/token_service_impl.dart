import 'package:data/models/remote/token/auth_token_dto.dart';
import 'package:data/source/remote/token_service.dart';
import 'package:data/utils/json_util.dart';
import 'package:remote/http/token_holder.dart';

import '../http/header_builder.dart';
import '../http/pcube_api.dart';

class TokenServiceImpl implements TokenService {
  final tokenHolder = TokenHolder();

  @override
  void setToken(String accessToken, String refreshToken) =>
      tokenHolder.setToken(accessToken, refreshToken);

  @override
  Future<AuthTokenDTO> getRefreshedToken() async {
    var response = await PCubeApi("/auth/token/refresh").get(
      headers: HeaderBuilder().contentTypeJson().withRefreshToken().build(),
    );

    var result = JsonUtil()
        .convertTo<AuthTokenDTO>(AuthTokenDTO.fromJson, response.body);

    tokenHolder.setToken(result.accessToken, result.refreshToken);
    return result;
  }

  @override
  Future<void> deleteToken() async {
    await PCubeApi("/auth/logout").delete();
  }
}
