import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserInfo {
  final bool isMember;
  final String? message;

  UserInfo({
    required this.isMember,
    required this.message,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      isMember: json['is_member'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
        'is_member': isMember,
        'message': message,
      };
}
