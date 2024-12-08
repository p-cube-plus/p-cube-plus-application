// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:domain/project/value_objects/project_detail_member_data.dart';
import 'package:domain/project/value_objects/project_type.dart';
import 'package:meta/meta.dart';

@immutable
class ProjectDetailData {
  final int projectId;
  final String title;
  final String platformType;
  final String graphicType;
  final ProjectType type;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isFindingMember;
  final List<ProjectDetailMemberData> memberList;

  const ProjectDetailData({
    required this.projectId,
    required this.title,
    required this.platformType,
    required this.graphicType,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.isFindingMember,
    required this.memberList,
  });
}
