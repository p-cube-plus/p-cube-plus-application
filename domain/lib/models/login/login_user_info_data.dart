class LoginUserInfoData {
  final bool isMember;
  final String? accessToken;
  final String? refreshToken;
  final String? message;

  LoginUserInfoData({
    required this.isMember,
    required this.accessToken,
    required this.refreshToken,
    required this.message,
  });
}
