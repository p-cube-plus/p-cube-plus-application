import 'package:domain/models/token/auth_token_data.dart';

abstract class TokenService {
  void setToken(String accessToken, String refreshToken);
  Future<AuthTokenData> getRefreshedToken();
  Future<void> deleteToken();
}
