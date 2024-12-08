import 'package:domain/member/value_objects/member_part_type.dart';
import 'package:domain/project/value_objects/project_role_tag.dart';
import 'package:meta/meta.dart';

@immutable
class ProjectDetailMemberData {
  final int memberId;
  final String name;
  final MemberPartType memberPartType;
  final List<ProjectRoleTag> projectRoleTags;

  ProjectDetailMemberData({
    required this.memberId,
    required this.name,
    required this.memberPartType,
    required this.projectRoleTags,
  });
}
