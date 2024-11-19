import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:domain/user/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

class FetchMemberAvailableAttendanceTypeUseCase {
  final _userRepository = GetIt.I.get<UserRepository>();

  Future<List<AttendanceType>> call() async {
    final userData = await _userRepository.getUserProfile();
    return [
      RegularMetting(),
      PartMettingAttendance(userData.partType),
    ];
  }
}
