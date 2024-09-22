import 'package:domain/attendance/repository/attendance_repository.dart';
import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:domain/attendance/value_objects/recent_attendance.dart';
import 'package:get_it/get_it.dart';

class FetchRecentAttendanceUseCase {
  final _attendanceRepository = GetIt.I.get<AttendanceRepository>();

  Future<List<RecentAttendance>> call(AttendanceType type) {
    return _attendanceRepository.getRecentAttendanceStatus(type, 4);
  }
}
