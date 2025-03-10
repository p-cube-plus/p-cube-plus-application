import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:domain/member/value_objects/member_part_type.dart';
import 'package:domain/member/value_objects/member_type.dart';
import 'package:meta/meta.dart';

@immutable
class MemberAttendanceState {
  final int memberId;
  final bool isActiveMember;
  final String name;
  final int grade;
  final MemberPartType partType;
  final MemberType memberType;

  final int attendanceId;
  final DateTime? firstAttendanceCheckTime;
  final DateTime? secondAttendanceCheckTime;
  final AttendanceStatusType attendanceStatusType;

  MemberAttendanceState({
    required this.memberId,
    required this.isActiveMember,
    required this.name,
    required this.grade,
    required this.partType,
    required this.memberType,
    required this.attendanceId,
    required this.attendanceStatusType,
    this.firstAttendanceCheckTime,
    this.secondAttendanceCheckTime,
  });

  bool get isExistFirstAttendance => firstAttendanceCheckTime == null;
  bool get isExistSecondAttendance => secondAttendanceCheckTime == null;

  // AttendanceStatusType get attendanceStatusType {
  //   if (!isExistSecondAttendance) {
  //     return firstAttendanceStatusType ?? _getDefaultFirstStatus();
  //   }

  //   final firstStatus = firstAttendanceStatusType ?? _getDefaultFirstStatus();
  //   final secondStatus =
  //       secondAttendanceStatusType ?? _getDefaultSecondStatus();

  //   if (firstStatus == AttendanceStatusType.success &&
  //       secondStatus == AttendanceStatusType.success) {
  //     return AttendanceStatusType.success;
  //   } else if (firstStatus == AttendanceStatusType.failed ||
  //       secondStatus == AttendanceStatusType.failed) {
  //     return AttendanceStatusType.failed;
  //   } else if (firstStatus == AttendanceStatusType.late ||
  //       secondStatus == AttendanceStatusType.late) {
  //     return AttendanceStatusType.late;
  //   } else if (firstStatus == AttendanceStatusType.blank) {
  //     return AttendanceStatusType.blank;
  //   } else if (firstStatus == AttendanceStatusType.pending ||
  //       secondStatus == AttendanceStatusType.pending) {
  //     return AttendanceStatusType.pending;
  //   } else {
  //     return AttendanceStatusType.failed;
  //   }
  // }
}
