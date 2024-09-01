import 'package:domain/models/project/project_data.dart';

import '../member/member_dto.dart';

class ProjectDTO {
  final int id;
  final String name;

  final String type;
  //String getType() => "${["메인", "꼬꼬마"][type]}";

  final String status;
  //String getStatus() =>
  //    "${["종료(완성)", "진행중", "준비중", "동결", "종료 임박", "종료(미완성)"][status]}";

  final DateTime? startDate;
  final DateTime? endDate;
  final String? graphic; // tag
  final List<String> platforms; // tag
  final bool isFindingMember;
  final bool isAbleInquiry; // 문의 가능한지
  final MemberDTO pm;
  final List<MemberDTO> members;

  ProjectDTO({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.graphic,
    required this.platforms,
    required this.isFindingMember,
    required this.isAbleInquiry,
    required this.pm,
    required this.members,
  });

  factory ProjectDTO.fromJson(Map<String, dynamic> json) {
    var platformList = json['platform']
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',')
        .map<String>((e) {
      return e.replaceAll(" ", "");
    }).toList();

    return ProjectDTO(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      status: json['status'],
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date']),
      endDate:
          json['end_date'] == null ? null : DateTime.parse(json['end_date']),
      graphic: json['graphic'],
      platforms: platformList,
      isFindingMember: json['is_finding_member'],
      isAbleInquiry: json['is_able_inquiry'],
      pm: MemberDTO.fromJson(json['pm']),
      members: (json['members'] as List)
          .map<MemberDTO>((data) => MemberDTO.fromJson(data))
          .toList(),
    );
  }
}

extension ProjectDTOExtension on ProjectDTO {
  ProjectData toDomain() {
    return ProjectData(
      id: id,
      name: name,
      type: type,
      status: status,
      startDate: startDate,
      endDate: endDate,
      graphic: graphic,
      platforms: platforms,
      isFindingMember: isFindingMember,
      isAbleInquiry: isAbleInquiry,
      pm: pm.toDomain(),
      members: members.map((e) => e.toDomain()).toList(),
    );
  }
}
