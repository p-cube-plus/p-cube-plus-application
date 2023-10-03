import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  static final TokenManager _instance = TokenManager._internal();
  factory TokenManager() => _instance;

  late FlutterSecureStorage _storage;

  TokenManager._internal() {
    _storage = new FlutterSecureStorage();
  }

  Future<String?> getAccessToken() async =>
      await _storage.read(key: "access_token");
  Future<String?> getRefreshToken() async =>
      await _storage.read(key: "refresh_token");

  void setAccessToken(String accessToken) {
    _storage.write(key: "access_token", value: accessToken);
  }

  void setRefreshToken(String refreshToken) {
    _storage.write(key: "refresh_token", value: refreshToken);
  }
}
