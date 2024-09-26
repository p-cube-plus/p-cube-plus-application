import 'package:domain/attendance/repository/attendance_repository.dart';
import 'package:domain/schedule/repository/schedule_repository.dart';
import 'package:get_it/get_it.dart';

class CachingBeforeStartingUseCase {
  final _scheduleRepository = GetIt.I.get<ScheduleRepository>();
  final _attendanceRepository = GetIt.I.get<AttendanceRepository>();

  Future<void> call(bool isLoggedIn) async {
    if (isLoggedIn) return;

    final today = DateTime.now();
    await Future.wait([
      _scheduleRepository.getScheduleListInMonth(today.year, today.month),
      _scheduleRepository.getUpcommingScheduleDetailList(),
      _scheduleRepository.getDailyScheduleDetailList(today),
      _attendanceRepository.getHomeAttendanceList(),
    ]);
  }
}
