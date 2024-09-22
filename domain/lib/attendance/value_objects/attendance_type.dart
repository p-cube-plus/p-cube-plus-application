import 'package:domain/member/value_objects/member_part_type.dart';

sealed class AttendanceType {}

class PartMettingAttendance implements AttendanceType {
  final MemberPartType partType;
  PartMettingAttendance(this.partType);
}

class RegularMetting implements AttendanceType {}
