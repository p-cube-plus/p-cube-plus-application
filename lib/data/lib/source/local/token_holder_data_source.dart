abstract class TokenHolderDataSource {
  Future<bool> isExistToken();
  Future<void> saveToken(String accessToken, String refreshToken);
  Future<void> deleteToken();
}
