import 'package:domain/attendance/repository/attendance_repository.dart';
import 'package:domain/attendance/value_objects/attendance_data.dart';
import 'package:domain/attendance/value_objects/today_attendance.dart';
import 'package:get_it/get_it.dart';

class FetchAttendanceStateUseCase {
  final _attendanceRepository = GetIt.I.get<AttendanceRepository>();

  Future<List<TodayAttendance>> call(AttendanceData data) {
    return _attendanceRepository.getTodayAttendanceList(data);
  }
}
