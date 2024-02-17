import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import 'member.dart';

@JsonSerializable()
class Project {
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
  final Member pm;
  final List<Member> members;

  Project({
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

  factory Project.fromJson(Map<String, dynamic> json) {
    var platformList = json['platform']
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',')
        .map<String>((e) {
      return e.replaceAll(" ", "");
    }).toList();

    return Project(
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
      pm: Member.fromJson(json['pm']),
      members: (json['members'] as List)
          .map<Member>((data) => Member.fromJson(data))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'status': status,
        'start_date': startDate == null
            ? null
            : DateFormat('yyyy-mm-dd').format(startDate!),
        'end_date':
            endDate == null ? null : DateFormat('yyyy-mm-dd').format(endDate!),
        'graphic': graphic,
        'platforms': platforms,
        'is_finding_member': isFindingMember,
        'is_able_inquiry': isAbleInquiry,
        'pm': pm,
        'members': members,
      };
}
