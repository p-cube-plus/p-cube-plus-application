class ValidateUserResponseDTO {
  final bool isMember;
  final String? accessToken;
  final String? refreshToken;

  ValidateUserResponseDTO({
    required this.isMember,
    required this.accessToken,
    required this.refreshToken,
  });

  factory ValidateUserResponseDTO.fromJson(Map<String, dynamic> json) {
    return ValidateUserResponseDTO(
      isMember: json['is_member'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
}
