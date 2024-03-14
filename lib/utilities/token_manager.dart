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

  Future<void> setAccessToken(String accessToken) async =>
      await _storage.write(key: "access_token", value: accessToken);
  Future<void> setRefreshToken(String refreshToken) async =>
      await _storage.write(key: "refresh_token", value: refreshToken);

  Future<void> deleteAccessToken() async =>
      await _storage.delete(key: "access_token");
  Future<void> deleteRefreshToken() async =>
      await _storage.delete(key: "refresh_token");
}
