import 'package:domain/attendance/value_objects/attendance_type.dart';
import 'package:domain/user/usecase/fetch_member_available_attendance_type_use_case.dart';
import 'package:presentation/common/base_viewmodel.dart';

class HomeAttendanceDetailViewModel extends BaseViewModel<void> {
  final _fetchMemberAvailableAttendanceTypeUseCase =
      FetchMemberAvailableAttendanceTypeUseCase();

  Future<List<AttendanceType>> fetchMemberAvailableAttendanceType() =>
      _fetchMemberAvailableAttendanceTypeUseCase();
}
