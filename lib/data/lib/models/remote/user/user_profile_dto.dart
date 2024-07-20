class UserProfileDTO {
  final String name;
  final String level;
  final int grade;
  final String part;
  final String restType;
  final String? profileImage;

  UserProfileDTO({
    required this.name,
    required this.level,
    required this.grade,
    required this.part,
    required this.restType,
    required this.profileImage,
  });

  factory UserProfileDTO.fromJson(Map<String, dynamic> json) {
    return UserProfileDTO(
      name: json['name'],
      level: json['level'],
      grade: json['grade'],
      part: json['part'],
      restType: json['rest_type'],
      profileImage: json['profile_image'],
    );
  }
}
