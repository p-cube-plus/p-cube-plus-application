import 'package:domain/attendance/repository/attendance_repository.dart';
import 'package:domain/attendance/value_objects/beacon_information.dart';
import 'package:get_it/get_it.dart';

class UpdateBeaconInformationUseCase {
  final _attendanceRepository = GetIt.I.get<AttendanceRepository>();

  Future<void> call(BeaconInformation newData) async {
    return await _attendanceRepository.setBeaconInformation(newData);
  }
}
