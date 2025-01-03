import 'package:domain/project/value_objects/project_type.dart';
import 'package:meta/meta.dart';

@immutable
class ProjectData {
  final int projectId;
  final String title;
  final ProjectType type;
  final DateTime startDate;
  final DateTime? endDate;
  final int memberCount;
  final bool isFindingMember;

  const ProjectData({
    required this.projectId,
    required this.title,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.memberCount,
    required this.isFindingMember,
  });

  bool get isFinishedProject => endDate?.isBefore(DateTime.now()) == true;
}
