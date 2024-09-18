import 'package:domain/attendance/models/attendance_check_data.dart';

import '../models/home_attendance_data.dart';

abstract interface class AttendanceRepository {
  Future<AttendanceCheckData> getAttendanceHistory(int id);
  Future<List<HomeAttendanceData>> getAttendanceList();
}
