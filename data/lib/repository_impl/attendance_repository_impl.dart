import 'package:domain/attendance/models/attendance_check_data.dart';
import 'package:domain/attendance/models/home_attendance_data.dart';
import 'package:domain/attendance/repository/attendance_repository.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  @override
  Future<AttendanceCheckData> getAttendanceHistory(int id) {
    // TODO: implement getAttendanceHistory
    throw UnimplementedError();
  }

  @override
  Future<List<HomeAttendanceData>> getAttendanceList() {
    // TODO: implement getAttendanceList
    throw UnimplementedError();
  }
}
