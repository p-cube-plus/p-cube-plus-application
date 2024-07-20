class LoginConfirmInfoDTO {
  final bool isVerified;

  LoginConfirmInfoDTO({
    required this.isVerified,
  });

  factory LoginConfirmInfoDTO.fromJson(Map<String, dynamic> json) {
    return LoginConfirmInfoDTO(
      isVerified: json['is_verified'],
    );
  }
}
