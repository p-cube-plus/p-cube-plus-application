import 'package:json_annotation/json_annotation.dart';

import 'member.dart';

@JsonSerializable()
class Project {
  final int id; // 프로젝트 Id

  final int type; // 메인, 꼬꼬마, 등등
  String getType() => "${["메인", "꼬꼬마"][type]}";

  final String name; // 프로젝트 이름
  final DateTime? startDate; // 시작 시간
  final DateTime? endDate; // 종료 시간
  final bool isEnd;

  final List<String> tags;
  final List<String> platforms;

  final List<Member> members;
  final Member pm;

  Project({
    required this.id,
    required this.type,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.isEnd,
    required this.tags,
    required this.platforms,
    required this.members,
    required this.pm,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date']),
      endDate:
          json['end_date'] == null ? null : DateTime.parse(json['end_date']),
      isEnd: json['is_end'],
      tags: (json['tags'] as List<dynamic>)
          .map<String>((e) => e.toString())
          .toList(),
      platforms: (json['platform'] as List<dynamic>)
          .map<String>((e) => e.toString())
          .toList(),
      members: (json['members'] as List<dynamic>)
          .map<Member>((e) => Member.fromJson(e))
          .toList(),
      pm: Member.fromJson(json['pm']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'name': name,
        'start_date': startDate.toString(),
        'end_date': endDate?.toString() ?? null,
        'is_end': isEnd,
        'tags': tags,
        'platform': platforms,
        'members': members,
        'pm': pm,
      };
}
