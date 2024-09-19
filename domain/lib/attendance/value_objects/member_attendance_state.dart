import 'package:domain/member/value_objects/member_part_type.dart';
import 'package:domain/member/value_objects/member_position_type.dart';
import 'package:meta/meta.dart';

import 'attendance_status_type.dart';

@immutable
class MemberAttendanceState {
  final String name;
  final int grade;
  final MemberPartType partType;
  final MemberPositionType positionType;
  final bool isExistSecondAttendance;

  final DateTime? firstAttendanceCheckTime;
  final AttendanceStatusType? firstAttendanceStatusType;

  final DateTime? secondAttendanceCheckTime;
  final AttendanceStatusType? secondAttendanceStatusType;

  const MemberAttendanceState({
    required this.name,
    required this.grade,
    required this.partType,
    required this.positionType,
    required this.isExistSecondAttendance,
    this.firstAttendanceCheckTime,
    this.firstAttendanceStatusType,
    this.secondAttendanceCheckTime,
    this.secondAttendanceStatusType,
  });

  AttendanceStatusType get attendanceStatusType {
    if (!isExistSecondAttendance) {
      return firstAttendanceStatusType ?? _getDefaultFirstStatus();
    }

    final firstStatus = firstAttendanceCheckTime ?? _getDefaultFirstStatus();
    final secondStatus =
        secondAttendanceStatusType ?? _getDefaultSecondStatus();

    if (firstStatus == AttendanceStatusType.success &&
        secondStatus == AttendanceStatusType.success) {
      return AttendanceStatusType.success;
    } else if (firstStatus == AttendanceStatusType.blank) {
      return AttendanceStatusType.blank;
    } else if (firstStatus == AttendanceStatusType.pending ||
        secondStatus == AttendanceStatusType.pending) {
      return AttendanceStatusType.pending;
    } else if (firstStatus == AttendanceStatusType.late ||
        secondStatus == AttendanceStatusType.late) {
      return AttendanceStatusType.late;
    } else {
      return AttendanceStatusType.failed;
    }
  }

  AttendanceStatusType _getDefaultFirstStatus() {
    return AttendanceStatusType.pending;
  }

  AttendanceStatusType _getDefaultSecondStatus() {
    if (!isExistSecondAttendance) {
      return AttendanceStatusType.success;
    }
    return AttendanceStatusType.pending;
  }
}
