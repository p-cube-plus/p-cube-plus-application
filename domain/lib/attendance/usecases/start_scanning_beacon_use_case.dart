import 'package:domain/attendance/repository/attendance_repository.dart';
import 'package:get_it/get_it.dart';

class StartScanningBeaconUseCase {
  final _attendanceRepository = GetIt.I.get<AttendanceRepository>();

  Future<void> call() {
    return _attendanceRepository.startScanningBeacon();
  }
}
