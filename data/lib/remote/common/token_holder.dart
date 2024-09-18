mixin class TokenHolder {
  String _accessToken = "";
  String _refreshToken = "";

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;

  void setToken(String accessToken, String refreshToken) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }
}
