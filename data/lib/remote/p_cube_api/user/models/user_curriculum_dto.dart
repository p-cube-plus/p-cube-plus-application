import 'package:domain/user/models/user_curriculum_data.dart';

class UserCurriculumDTO {
  final bool completed;
  final String? name;
  final DateTime? startDate;
  final DateTime? endDate;

  UserCurriculumDTO({
    required this.completed,
    required this.name,
    required this.startDate,
    required this.endDate,
  });

  factory UserCurriculumDTO.fromJson(Map<String, dynamic> json) {
    return UserCurriculumDTO(
      completed: json['completed'],
      name: json['current_curriculum'],
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date']),
      endDate:
          json['end_date'] == null ? null : DateTime.parse(json['end_date']),
    );
  }
}

extension UserCurriculumDTOExtension on UserCurriculumDTO {
  UserCurriculumData toDomain() {
    return UserCurriculumData(
      completed: completed,
      name: name,
      startDate: startDate,
      endDate: endDate,
    );
  }
}