import 'package:domain/attendance/value_objects/attendance_data.dart';
import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:meta/meta.dart';

import 'attendance_status_type.dart';

@immutable
class TodayAttendance {
  final int id;
  final int attendanceSequence;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? attendanceTime;
  const TodayAttendance({
    required this.id,
    required this.attendanceSequence,
    this.startTime,
    this.endTime,
    this.attendanceTime,
  });

  bool get didAttend => attendanceTime != null;
  bool get canAttend => startTime != null && endTime != null;

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
