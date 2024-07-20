import 'package:data/models/remote/attendance/attendance_check_dto.dart';

abstract class AttendanceService {
  Future<AttendanceCheckDTO> getAttendanceHistory(int id);
}
