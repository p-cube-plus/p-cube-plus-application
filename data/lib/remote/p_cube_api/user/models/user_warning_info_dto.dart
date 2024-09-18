import 'package:domain/user/models/user_warning_info_data.dart';

class UserWarningInfoDTO {
  final int category;
  final DateTime? date;
  final String? description;
  final String? comment;
  final int id;

  UserWarningInfoDTO({
    required this.category,
    required this.date,
    required this.description,
    required this.comment,
    required this.id,
  });

  factory UserWarningInfoDTO.fromJson(Map<String, dynamic> json) {
    return UserWarningInfoDTO(
      category: json['category'],
      date: json['date'],
      description: json['description'],
      comment: json['comment'],
      id: json['id'],
    );
  }
}

extension UserWarningInfoDTOExtension on UserWarningInfoDTO {
  UserWarningInfoData toDomain() {
    return UserWarningInfoData(
      category: category,
      date: date,
      description: description,
      comment: comment,
      id: id,
    );
  }
}