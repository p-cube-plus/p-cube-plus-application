import 'package:domain/attendance/repository/attendance_repository.dart';
import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:domain/attendance/value_objects/member_attendance_state.dart';
import 'package:get_it/get_it.dart';

class FetchUserAttendanceListUseCase {
  final _attendanceRepository = GetIt.I.get<AttendanceRepository>();

  Future<List<MemberAttendanceState>> call(
      AttendanceType attendanceType, DateTime searchDate) {
    return _attendanceRepository.getMemberAttendanceStateList(
      attendanceType,
      searchDate,
    );
  }
}
