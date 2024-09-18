import 'package:domain/user/models/user_project_data.dart';

class UserProjectDTO {
  final int id;
  final String name;
  final String type;
  final String status;
  final DateTime startDate;
  final DateTime? endDate;
  final String? graphic;
  final List<String> platform;
  final bool isFindingMember;
  final bool isAbleInquiry;

  UserProjectDTO({
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

  factory UserProjectDTO.fromJson(Map<String, dynamic> data) {
    var platformList = data['platform']
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',')
        .map<String>((e) {
      return e.replaceAll(" ", "");
    }).toList();

    return UserProjectDTO(
      id: data['id'],
      name: data['name'],
      type: data['type'],
      status: data['status'],
      startDate: DateTime.parse(data['start_date']),
      endDate: data['end_date'] != null
          ? DateTime.parse(data['end_date'])
          : data['end_date'],
      graphic: data['graphic'],
      platform: platformList,
      isFindingMember: data['is_finding_member'],
      isAbleInquiry: data['is_able_inquiry'],
    );
  }
}

extension UserProjectDTOExtension on UserProjectDTO {
  UserProjectData toDomain() {
    return UserProjectData(
      id: id,
      name: name,
      type: type,
      status: status,
      startDate: startDate,
      endDate: endDate,
      graphic: graphic,
      platform: platform,
      isFindingMember: isFindingMember,
      isAbleInquiry: isAbleInquiry,
    );
  }
}
