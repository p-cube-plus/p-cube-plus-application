import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:meta/meta.dart';

import 'attendance_status_type.dart';

@immutable
class TodayAttendance {
  final int id;
  final int attendanceSequence;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime? attendanceTime;
  const TodayAttendance({
    required this.id,
    required this.attendanceSequence,
    required this.startTime,
    required this.endTime,
    this.attendanceTime,
  });

  bool get didAttend => attendanceTime != null;

  AttendanceStatusType get attendanceStatus {
    if (attendanceTime == null) {
      return AttendanceStatusType.pending;
    } else if (attendanceTime!.isBetweenDates(startTime, endTime)) {
      return AttendanceStatusType.success;
    } else if (attendanceTime!.isAfter(endTime.add(Duration(minutes: 15)))) {
      return AttendanceStatusType.late;
    } else {
      return AttendanceStatusType.failed;
    }
  }

  TodayAttendance copyWith({
    int? id,
    int? attendanceSequence,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? attendanceTime,
  }) {
    return TodayAttendance(
      id: id ?? this.id,
      attendanceSequence: attendanceSequence ?? this.attendanceSequence,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      attendanceTime: attendanceTime ?? this.attendanceTime,
    );
  }
}
