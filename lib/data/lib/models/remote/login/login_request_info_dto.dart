class LoginRequestInfoDTO {
  final bool isValid;
  final String? cookie;

  LoginRequestInfoDTO({
    required this.isValid,
    required this.cookie,
  });
}
