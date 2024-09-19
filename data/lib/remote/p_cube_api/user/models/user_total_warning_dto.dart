class UserTotalWarningDTO {
  final double totalWarning;

  UserTotalWarningDTO({
    required this.totalWarning,
  });

  factory UserTotalWarningDTO.fromJson(Map<String, dynamic> json) {
    return UserTotalWarningDTO(
      totalWarning: json['total_warning'],
    );
  }
}
