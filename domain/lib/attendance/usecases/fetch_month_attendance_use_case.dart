import 'package:domain/attendance/repository/attendance_repository.dart';
import 'package:domain/attendance/value_objects/attendance_data.dart';
import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:get_it/get_it.dart';

class FetchMonthAttendanceUseCase {
  final _attendanceRepository = GetIt.I.get<AttendanceRepository>();

  Future<List<AttendanceData>> call(
    AttendanceType type,
    DateTime selectedDate,
  ) async {
    return await _attendanceRepository.getAttendanceExistDayListInMonth(
      type,
      selectedDate.year,
      selectedDate.month,
    );
  }
}
