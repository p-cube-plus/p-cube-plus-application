import 'package:domain/attendance/repository/attendance_repository.dart';
import 'package:domain/attendance/value_objects/today_attendance.dart';
import 'package:get_it/get_it.dart';

class AttendUseCase {
  final _attendanceRepository = GetIt.I.get<AttendanceRepository>();

  Future<TodayAttendance> call(TodayAttendance data) {
    return _attendanceRepository.attend(
      data.id,
      data.attendanceSequence,
      DateTime.now(),
    );
  }
}
