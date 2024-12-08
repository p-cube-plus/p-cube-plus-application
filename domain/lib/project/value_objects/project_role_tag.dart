import 'package:meta/meta.dart';

@immutable
class ProjectRoleTag {
  final String role;
  final bool isProjectLead;
  ProjectRoleTag({
    required this.role,
    required this.isProjectLead,
  });
}
