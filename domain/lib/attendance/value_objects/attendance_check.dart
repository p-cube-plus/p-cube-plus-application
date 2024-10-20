import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:meta/meta.dart';

@immutable
class AttendanceCheck {
  final int id;
  final int sequenceNumber;
  final DateTime attendanceCheckDateTime;
  final AttendanceStatusType status;
  const AttendanceCheck({
    required this.id,
    required this.sequenceNumber,
    required this.attendanceCheckDateTime,
    required this.status,
  });
}