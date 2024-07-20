class LoginUserInfoDTO {
  final bool isMember;
  final String? accessToken;
  final String? refreshToken;
  final String? message;

  LoginUserInfoDTO({
    required this.isMember,
    required this.accessToken,
    required this.refreshToken,
    required this.message,
  });

  factory LoginUserInfoDTO.fromJson(Map<String, dynamic> json) {
    return LoginUserInfoDTO(
      isMember: json['is_member'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      message: json['message'],
    );
  }
}
