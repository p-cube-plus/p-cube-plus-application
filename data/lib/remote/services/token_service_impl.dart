import 'package:domain/models/token/auth_token_data.dart';
import 'package:domain/services/token_service.dart';

import '../../utils/json_util.dart';
import '../http/header_builder.dart';
import '../http/pcube_api.dart';
import '../http/token_holder.dart';
import '../models/token/auth_token_dto.dart';

class TokenServiceImpl implements TokenService {
  final tokenHolder = TokenHolder();

  @override
  void setToken(String accessToken, String refreshToken) =>
      tokenHolder.setToken(accessToken, refreshToken);

  @override
  Future<AuthTokenData> getRefreshedToken() async {
    var response = await PCubeApi("/auth/token/refresh").get(
      headers: HeaderBuilder().contentTypeJson().withRefreshToken().build(),
    );

    var result = JsonUtil()
        .convertTo<AuthTokenDTO>(AuthTokenDTO.fromJson, response.body);

    tokenHolder.setToken(result.accessToken, result.refreshToken);
    return result.toDomain();
  }

  @override
  Future<void> deleteToken() async {
    await PCubeApi("/auth/logout").delete();
  }
}
