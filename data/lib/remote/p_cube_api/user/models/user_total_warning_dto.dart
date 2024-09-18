import 'package:domain/user/models/user_total_warning_data.dart';

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

extension UserTotalWarningDTOExtension on UserTotalWarningDTO {
  UserTotalWarningData toDomain() {
    return UserTotalWarningData(
      totalWarning: totalWarning,
    );
  }
}
