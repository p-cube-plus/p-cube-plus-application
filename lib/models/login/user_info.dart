import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserInfo {
  final bool isMember;
  final String? accessToken;
  final String? refreshToken;
  final String? message;

  UserInfo({
    required this.isMember,
    required this.accessToken,
    required this.refreshToken,
    required this.message,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      isMember: json['is_member'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        'is_member': isMember,
        'access_token': accessToken,
        'refresh_token': refreshToken,
        'message': message,
      };
}
