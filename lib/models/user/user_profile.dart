import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserProfile {
  final String name;
  final String level;
  final int grade;
  final String part;
  final String restType;
  final String? profileImage;

  UserProfile({
    required this.name,
    required this.level,
    required this.grade,
    required this.part,
    required this.restType,
    required this.profileImage,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'],
      level: json['level'],
      grade: json['grade'],
      part: json['part'],
      restType: json['rest_type'],
      profileImage: json['profile_image'],
    );
  }

  Map<String, dynamic> toJson() => {
        '${#name}': name,
        'level': level,
        'grade': grade,
        'part': part,
        'rest_type': restType,
        'profile_image': profileImage,
      };
}
