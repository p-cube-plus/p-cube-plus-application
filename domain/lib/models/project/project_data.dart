import 'package:domain/models/member/member_data.dart';

class ProjectData {
  final int id;
  final String name;
  final String type;
  final String status;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? graphic;
  final List<String> platforms;
  final bool isFindingMember;
  final bool isAbleInquiry;
  final MemberData pm;
  final List<MemberData> members;

  ProjectData({
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
}
