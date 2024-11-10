import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:meta/meta.dart';

@immutable
class AttendanceDetailData {
  final int id;
  final DateTime attendanceDate;
  final AttendanceType type;
  final DateTime? firstAttendanceStartTime;
  final DateTime? firstAttendanceEndTime;
  final DateTime? secondAttendanceStartTime;
  final DateTime? secondAttendanceEndTime;
  AttendanceDetailData({
    required this.id,
    required this.attendanceDate,
    required this.type,
    this.firstAttendanceStartTime,
    this.firstAttendanceEndTime,
    this.secondAttendanceStartTime,
    this.secondAttendanceEndTime,
  });

  bool get isExistFirstAttendance =>
      firstAttendanceStartTime != null && firstAttendanceEndTime != null;
  bool get isExistSecondAttendance =>
      secondAttendanceStartTime != null && secondAttendanceEndTime != null;
}
