import 'package:domain/attendance/repository/attendance_repository.dart';
import 'package:domain/attendance/value_objects/attendance_check.dart';
import 'package:domain/attendance/value_objects/today_attendance.dart';
import 'package:get_it/get_it.dart';

class AttendUseCase {
  final _attendanceRepository = GetIt.I.get<AttendanceRepository>();

  Future<TodayAttendance> call(TodayAttendance data) async {
    final attendanceTime = DateTime.now();
    final newAttendance = data.copyWith(attendanceTime: attendanceTime);

    final checkData =
        await _attendanceRepository.getLocalAttendanceData(data.id);
    final isFailedBefore = checkData != null;
    if (isFailedBefore) {
      await _attendanceRepository.insertAttendanceData(checkData);
    } else {
      await _attendanceRepository.insertAttendanceData(
        AttendanceCheck(
          id: newAttendance.id,
          sequenceNumber: newAttendance.attendanceSequence,
          attendanceCheckDateTime: attendanceTime,
          status: newAttendance.attendanceStatus,
        ),
      );
    }

    return newAttendance;
  }
}
