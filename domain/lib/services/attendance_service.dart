import 'package:domain/models/attendance/attendance_check_data.dart';

abstract class AttendanceService {
  Future<AttendanceCheckData> getAttendanceHistory(int id);
}
