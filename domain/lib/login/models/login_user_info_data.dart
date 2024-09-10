class LoginUserInfoData {
  final bool isMember;
  final String? accessToken;
  final String? refreshToken;

  LoginUserInfoData({
    required this.isMember,
    required this.accessToken,
    required this.refreshToken,
  });
}
