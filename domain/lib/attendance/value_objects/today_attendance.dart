import 'package:domain/attendance/value_objects/attendance_data.dart';
import 'package:domain/extensions/date_time_extension.dart';
import 'package:meta/meta.dart';

import 'attendance_status_type.dart';

@immutable
class TodayAttendance {
  final AttendanceData attendance;
  final int sequenceNumber;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? attendanceTime;
  const TodayAttendance({
    required this.attendance,
    required this.sequenceNumber,
    this.startTime,
    this.endTime,
    this.attendanceTime,
  });

  bool get didAttend => attendanceTime != null;
  bool get canAttend => endTime != null && endTime != null;

  AttendanceStatusType get attendanceStatus {
    if (attendanceTime == null || endTime == null) {
      return AttendanceStatusType.pending;
    } else if (attendanceTime!.isBetweenDates(startTime, endTime)) {
      return AttendanceStatusType.success;
    } else if (attendanceTime!.isBefore(endTime!.add(Duration(minutes: 15)))) {
      return AttendanceStatusType.late;
    } else {
      return AttendanceStatusType.failed;
    }
  }
}
