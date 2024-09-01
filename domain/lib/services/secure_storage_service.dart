abstract class SecureStorageService {
  Future<String?> getAccessToken();
  Future<void> saveAccessToken(String value);
  Future<void> deleteAccessToken();
  Future<String?> getRefreshToken();
  Future<void> saveRefreshToken(String value);
  Future<void> deleteRefreshToken();
}
