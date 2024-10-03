import 'package:domain/attendance/repository/attendance_repository.dart';
import 'package:domain/attendance/value_objects/today_attendance.dart';
import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:get_it/get_it.dart';

class FetchCanAttendUseCase {
  final _attendanceRepository = GetIt.I.get<AttendanceRepository>();

  bool call(TodayAttendance data) {
    final isAvailableTime =
        DateTime.now().isBetweenDates(data.startTime, data.endTime);
    final isBeaconDetected = _attendanceRepository.getBeaconDetected();
    return isAvailableTime && isBeaconDetected;
  }
}
