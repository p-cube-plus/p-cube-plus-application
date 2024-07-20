import 'package:data/models/remote/token/auth_token_dto.dart';

abstract class TokenService {
  void setToken(String accessToken, String refreshToken);
  Future<AuthTokenDTO> getRefreshedToken();
  Future<void> deleteToken();
}
