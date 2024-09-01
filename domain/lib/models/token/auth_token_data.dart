class AuthTokenData {
  final String accessToken;
  final String refreshToken;
  final String? message;

  const AuthTokenData({
    required this.accessToken,
    required this.refreshToken,
    required this.message,
  });
}
