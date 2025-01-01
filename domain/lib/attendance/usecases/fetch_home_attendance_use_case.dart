import 'package:domain/attendance/repository/attendance_repository.dart';
import 'package:domain/attendance/value_objects/home_attendance.dart';
import 'package:get_it/get_it.dart';

class FetchHomeAttendanceUseCase {
  final _attendanceRepository = GetIt.I.get<AttendanceRepository>();

  Future<List<HomeAttendance>> call() async {
    return _attendanceRepository.getHomeAttendanceList();
  }
}
