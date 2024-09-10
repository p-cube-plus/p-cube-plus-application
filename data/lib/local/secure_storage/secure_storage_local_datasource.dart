import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'secure_storage_key_type.dart';

class SecureStorageLocalDatasource {
  final _storage = const FlutterSecureStorage();

  Future<String?> getAccessToken() async {
    return await _storage.read(key: SecureStorageKey.pcubeRefreshToken.name);
  }

  Future<void> saveAccessToken(String value) async {
    _storage.write(
      key: SecureStorageKey.pcubeAccessToken.name,
      value: value,
    );
  }

  Future<void> deleteAccessToken() async {
    _storage.delete(key: SecureStorageKey.pcubeAccessToken.name);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: SecureStorageKey.pcubeRefreshToken.name);
  }

  Future<void> saveRefreshToken(String value) async {
    _storage.write(
      key: SecureStorageKey.pcubeRefreshToken.name,
      value: value,
    );
  }

  Future<void> deleteRefreshToken() async {
    _storage.delete(key: SecureStorageKey.pcubeRefreshToken.name);
  }
}
