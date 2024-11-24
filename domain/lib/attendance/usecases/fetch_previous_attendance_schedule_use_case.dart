import 'package:domain/attendance/repository/attendance_repository.dart';
import 'package:domain/attendance/value_objects/attendance_detail_data.dart';
import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:get_it/get_it.dart';

class FetchPreviousAttendanceScheduleUseCase {
  final _attendanceRepository = GetIt.I.get<AttendanceRepository>();

  Future<AttendanceDetailData> call(AttendanceType type, DateTime date) {
    return _attendanceRepository.getPreviousAttendanceDetail(type, date);
  }
}
