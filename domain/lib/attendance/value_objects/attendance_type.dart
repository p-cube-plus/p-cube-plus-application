import 'package:domain/member/value_objects/member_part_type.dart';

sealed class AttendanceType {
  final String name;
  AttendanceType(this.name);
}

class PartMettingAttendance implements AttendanceType {
  final MemberPartType partType;
  PartMettingAttendance(this.partType);

  @override
  String get name => switch (partType) {
        MemberPartType.design => "디자인 파트",
        MemberPartType.development => "프로그래밍 파트",
        MemberPartType.art => "아트 파트",
      };
}

class RegularMetting implements AttendanceType {
  @override
  String get name => "정기";
}
