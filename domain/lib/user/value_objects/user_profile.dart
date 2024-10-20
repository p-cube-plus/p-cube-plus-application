import 'package:domain/member/value_objects/member_part_type.dart';
import 'package:domain/member/value_objects/member_position_type.dart';
import 'package:meta/meta.dart';

@immutable
class UserProfile {
  final String name;
  final MemberPartType partType;
  final MemberPositionType positionType;
  const UserProfile({
    required this.name,
    required this.partType,
    required this.positionType,
  });
}