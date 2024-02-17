import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AuthToken {
  final String? accessToken;
  final String? refreshToken;
  final String? message;

  AuthToken({
    required this.accessToken,
    required this.refreshToken,
    required this.message,
  });

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'refresh_token': refreshToken,
        'message': message,
      };
}
