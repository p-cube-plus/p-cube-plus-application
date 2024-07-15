class AuthTokenDTO {
  final String accessToken;
  final String refreshToken;
  final String? message;

  const AuthTokenDTO({
    required this.accessToken,
    required this.refreshToken,
    required this.message,
  });

  factory AuthTokenDTO.fromJson(Map<String, dynamic> json) {
    return AuthTokenDTO(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      message: json['message'],
    );
  }
}
