import 'package:meta/meta.dart';

@immutable
class AttendanceData {
  final int id;
  final DateTime attendanceDate;
  const AttendanceData({
    required this.id,
    required this.attendanceDate,
  });
}
