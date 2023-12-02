import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserProject {
  final String id;
  final String name;
  final String type;
  final String status;
  final DateTime startDate;
  final DateTime? endDate;
  final String? graphic;
  final List<String> platform;
  final bool isFindingMember;
  final bool isAbleInquiry;

  UserProject({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.graphic,
    required this.platform,
    required this.isFindingMember,
    required this.isAbleInquiry,
  });

  factory UserProject.fromJson(Map<String, dynamic> json) {
    return UserProject(
      id: json['id'].toString(),
      name: json['name'],
      type: json['type'],
      status: json['status'],
      startDate: DateTime.parse(json['start_date']),
      endDate: json['end_date'] ?? DateTime.parse(json['end_date']),
      graphic: json['graphic'],
      platform: json['platform'],
      isFindingMember: json['is_finding_member'],
      isAbleInquiry: json['is_able_inquiry'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'status': status,
        'start_date': startDate,
        'end_date': endDate,
        'graphic': graphic,
        'platform': platform,
        'is_finding_member': isFindingMember,
        'is_able_inquiry': isAbleInquiry,
      };
}
