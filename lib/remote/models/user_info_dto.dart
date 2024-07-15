class UserInfoDTO {
  final bool isMember;
  final String? accessToken;
  final String? refreshToken;
  final String? message;

  UserInfoDTO({
    required this.isMember,
    required this.accessToken,
    required this.refreshToken,
    required this.message,
  });

  factory UserInfoDTO.fromJson(Map<String, dynamic> json) {
    return UserInfoDTO(
      isMember: json['is_member'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      message: json['message'],
    );
  }
}
