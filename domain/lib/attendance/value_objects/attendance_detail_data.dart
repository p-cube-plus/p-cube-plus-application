import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:domain/attendance/value_objects/member_attendance_state.dart';
import 'package:meta/meta.dart';

@immutable
class AttendanceDetailData {
  final int attendanceScheduleId;
  final DateTime attendanceDate;
  final AttendanceType type;
  final List<MemberAttendanceState> memberStateList;
  final DateTime firstAttendanceStartTime;
  final DateTime firstAttendanceEndTime;
  final DateTime? secondAttendanceStartTime;
  final DateTime? secondAttendanceEndTime;

  AttendanceDetailData({
    required this.attendanceScheduleId,
    required this.attendanceDate,
    required this.type,
    required this.memberStateList,
    required this.firstAttendanceStartTime,
    required this.firstAttendanceEndTime,
    this.secondAttendanceStartTime,
    this.secondAttendanceEndTime,
  });

  bool get isExistSecondAttendance =>
      secondAttendanceStartTime != null && secondAttendanceEndTime != null;
}
