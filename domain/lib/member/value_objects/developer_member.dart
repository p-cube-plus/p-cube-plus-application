import 'package:domain/member/value_objects/member_part_type.dart';
import 'package:domain/member/value_objects/member_type.dart';
import 'package:meta/meta.dart';

@immutable
class DeveloperMember {
  final String name;
  final String departmentName;
  final int studentNumber;
  final MemberPartType partType;
  final MemberType positionType;
  const DeveloperMember({
    required this.name,
    required this.departmentName,
    required this.studentNumber,
    required this.partType,
    required this.positionType,
  });
}
