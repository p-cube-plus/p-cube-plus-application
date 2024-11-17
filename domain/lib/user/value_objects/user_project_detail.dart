import 'package:domain/project/value_objects/project_type.dart';
import 'package:meta/meta.dart';

@immutable
class UserProjectDetail {
  final int projectId;
  final String title;
  final ProjectType type;
  final DateTime startDate;
  final DateTime? endDate;
  final int memberCount;
  const UserProjectDetail({
    required this.projectId,
    required this.title,
    required this.type,
    required this.startDate,
    this.endDate,
    required this.memberCount,
  });
}
