import 'attendance_type.dart';

class HomeAttendanceData {
  int attendanceId;
  AttendanceType attendanceType;
  DateTime attendanceDate;
  String title;
  HomeAttendanceData({
    required this.attendanceId,
    required this.attendanceType,
    required this.attendanceDate,
    required this.title,
  });
}
