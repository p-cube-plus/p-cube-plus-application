import 'attendance_data.dart';
import 'attendance_state_data.dart';

class AttendanceCheckData {
  final AttendanceData attendance;
  final List<AttendanceStateData> recordList;

  const AttendanceCheckData({
    required this.attendance,
    required this.recordList,
  });
}
