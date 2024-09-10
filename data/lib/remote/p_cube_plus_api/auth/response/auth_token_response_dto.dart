class AuthTokenResponseDTO {
  final String accessToken;
  final String refreshToken;

  const AuthTokenResponseDTO({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthTokenResponseDTO.fromJson(Map<String, dynamic> json) {
    return AuthTokenResponseDTO(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
}
