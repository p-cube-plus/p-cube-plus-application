import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  static final TokenManager _instance = TokenManager();
  factory TokenManager() => _instance;

  String get accessToken => _accessToken;
  String _accessToken = "";

  final _storage = FlutterSecureStorage();
  final _accessTokenKey = "access_token";
  final _refreshTokenKey = "refresh_token";

  Future<void> saveToken(String accessToken, String refreshToken) async {
    _accessToken = accessToken;
    _storage.write(key: _accessTokenKey, value: accessToken);
    _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<void> deleteRefreshToken() async =>
      await _storage.delete(key: _refreshTokenKey);

  Future<bool> setTokenAndGetIsExistToken() async {
    var token = await _storage.read(key: _accessTokenKey);
    if (token == null) return false;
    _accessToken = token;
    return false;
  }

  Future<String> getRefreshToken() async =>
      await _storage.read(key: _refreshTokenKey) ?? "";
}
