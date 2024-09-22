import 'package:domain/attendance/value_objects/attendance_status_type.dart';

class RecentAttendance {
  final AttendanceStatusType type;
  final DateTime date;
  RecentAttendance({
    required this.type,
    required this.date,
  });
}
