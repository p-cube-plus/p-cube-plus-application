class UserWarningDTO {
  final totalWarning;

  UserWarningDTO({
    required this.totalWarning,
  });

  factory UserWarningDTO.fromJson(Map<String, dynamic> json) {
    return UserWarningDTO(
      totalWarning: json['total_warning'],
    );
  }
}
