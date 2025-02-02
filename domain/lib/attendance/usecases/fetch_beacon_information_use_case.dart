import 'package:domain/attendance/repository/attendance_repository.dart';
import 'package:domain/attendance/value_objects/beacon_information.dart';
import 'package:get_it/get_it.dart';

class FetchBeaconInformationUseCase {
  final _attendanceRepository = GetIt.I.get<AttendanceRepository>();

  Future<BeaconInformation> call() async {
    return await _attendanceRepository.getBeaconInformation();
  }
}
