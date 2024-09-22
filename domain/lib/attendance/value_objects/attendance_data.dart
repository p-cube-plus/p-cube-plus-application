import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:meta/meta.dart';

@immutable
class AttendanceData {
  final int id;
  final DateTime attendanceDate;
  final AttendanceType type;
  const AttendanceData({
    required this.id,
    required this.attendanceDate,
    required this.type,
  });
}
