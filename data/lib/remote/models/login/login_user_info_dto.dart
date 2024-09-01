import 'package:domain/models/login/login_user_info_data.dart';

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

extension LoginUserInfoDTOExtension on LoginUserInfoDTO {
  LoginUserInfoData toDomain() {
    return LoginUserInfoData(
      isMember: isMember,
      accessToken: accessToken,
      refreshToken: refreshToken,
      message: message,
    );
  }
}
