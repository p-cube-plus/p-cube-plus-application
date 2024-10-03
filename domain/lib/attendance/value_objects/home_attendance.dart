import 'package:domain/schedule/value_objects/schedule_type.dart';
import 'package:meta/meta.dart';

import 'attendance_data.dart';

@immutable
class HomeAttendance {
  final AttendanceData attendanceData;
  final ScheduleType scheduleType;
  final String title;
  const HomeAttendance({
    required this.attendanceData,
    required this.scheduleType,
    required this.title,
  });
}
