class TokenHolder {
  TokenHolder._internal();
  static final TokenHolder _instance = TokenHolder._internal();
  factory TokenHolder() => _instance;

  String _accessToken = "";
  String _refreshToken = "";

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;

  void setToken(String accessToken, String refreshToken) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }
}
